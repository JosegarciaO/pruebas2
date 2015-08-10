# -*- coding: utf-8 -*-

class ReportsController < ApplicationController
	before_filter :getCatalogos, :only => :index

	authorize_resource :class => false
	respond_to :json

	def report_certificates
		if res = get_report_data(params)
			if params[:type_file] == 'PDF'
				if params[:type_rpt] == '1'
					respond_to do |format|
						format.pdf { render_pdf_emitted(res) }
					end
				elsif params[:type_rpt] == '2'
					respond_to do |format|
						format.pdf { render_pdf_canceled(res) }
					end
				end
			elsif params[:type_file] == 'XLS'
				if params[:type_rpt] == '1'
					respond_to do |format|
						format.xlsx { render_xls_emitted(res) }
					end
				elsif params[:type_rpt] == '2'
					respond_to do |format|
						format.xlsx { render_xls_canceled(res) }
					end
				end
			else
				respond_to do |format|
					format.json { render :json => res }
				end
			end
		end
	end
	

	private

	def getCatalogos
		@all_status = ListasGenerales::get_all_status
		@insurances = Insurance.all
		@type_rpt   = [{:name =>'Emitidas',:id=>1},{:name=>'Canceladas',:id=>2}].map{ |a| [a[:name],a[:id]] }
		@start = Date.today().strftime("%Y-%m-01")
		@today = Date.today().strftime("%Y-%m-%d")
	end

	def render_pdf_emitted(collection)
		report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'rpt_certificados.tlf')

		report.layout.config.list(:default) do
			use_stores :suma_importes_mn => 0, :suma_primas_mn => 0, :suma_importes_us => 0, :suma_primas_us => 0
			events.on :footer_insert do |e|
				e.section.item(:totales_importe_mn).value(e.store.suma_importes_mn)
				e.section.item(:totales_prima_mn).value(e.store.suma_primas_mn)
				e.section.item(:totales_importe_us).value(e.store.suma_importes_us)
				e.section.item(:totales_prima_us).value(e.store.suma_primas_us)
			end
		end

		report.start_new_page do |page|
		  page.values encabezado: "REPORTE DE CERTIFICADOS EMITIDOS"
		end

		if collection
			collection.each do |certif|
				report.page.list(:default) do |list|
					list.add_row :folio => certif.num_constancia,
						:fecha => certif.emission_date.to_date.strftime("%d-%m-%Y"),
						:moneda => ListasGenerales::getNombreMoneda(certif.moneda),
						:importe => certif.importe,
						:cuota_base => (certif.base_fee * 100).to_s() + "%",
						:gasto_exped => certif.expedition_fee,
						:iva => certif.iva_amount,
						:prima_total => certif.total_prime
					
					list.store.suma_importes_mn += certif.importe     if certif.moneda == 'M'
					list.store.suma_primas_mn   += certif.total_prime if certif.moneda == 'M'
					list.store.suma_importes_us += certif.importe     if certif.moneda == 'U'
					list.store.suma_primas_us   += certif.total_prime if certif.moneda == 'U'
				end
			end
		end

		send_data report.generate, filename: 'rpt_emitidos.pdf', type: 'application/pdf', disposition: 'attachment'
	end

	def render_pdf_canceled(collection)
		report = ThinReports::Report.new layout: File.join(Rails.root, 'app', 'reports', 'rpt_certificados.tlf')

		report.layout.config.list(:default) do
			use_stores :suma_importes_mn => 0, :suma_primas_mn => 0, :suma_importes_us => 0, :suma_primas_us => 0
			events.on :footer_insert do |e|
				e.section.item(:totales_importe_mn).value(e.store.suma_importes_mn)
				e.section.item(:totales_prima_mn).value(e.store.suma_primas_mn)
				e.section.item(:totales_importe_us).value(e.store.suma_importes_us)
				e.section.item(:totales_prima_us).value(e.store.suma_primas_us)
			end
		end

		report.start_new_page do |page|
		  page.values encabezado: "REPORTE DE CERTIFICADOS CANCELADOS"
		end

		if collection
			collection.each do |certif|
				report.page.list(:default) do |list|
					list.add_row :folio => certif.num_constancia,
						:moneda => ListasGenerales::getNombreMoneda(certif.moneda),
						:fecha => certif.canceled_at.to_date.strftime("%d-%m-%Y"),
						:importe => certif.importe,
						:cuota_base => (certif.base_fee * 100).to_s() + "%",
						:gasto_exped => certif.expedition_fee,
						:iva => certif.iva_amount,
						:prima_total => certif.total_prime
					
					list.store.suma_importes_mn += certif.importe     if certif.moneda == 'M'
					list.store.suma_primas_mn   += certif.total_prime if certif.moneda == 'M'
					list.store.suma_importes_us += certif.importe     if certif.moneda == 'U'
					list.store.suma_primas_us   += certif.total_prime if certif.moneda == 'U'
				end
			end
		end

		send_data report.generate, filename: 'rpt_cancelados.pdf', type: 'application/pdf', disposition: 'attachment'
	end

	def render_xls_emitted(collection)
		p = Axlsx::Package.new
		p.workbook do |wb|
			# -- formatos
			headers  = wb.styles.add_style(:b => true, :sz => 9, :alignment => { :horizontal=> :center } )
			percent  = wb.styles.add_style(:format_code => "0.00%", :sz => 10)
			currency = wb.styles.add_style(:format_code => "$#,0.00", :sz => 10)
			date   = wb.styles.add_style(:format_code => "dd/mm/yyyy", :alignment => { :horizontal=> :center })
			moneda = wb.styles.add_style(:sz => 10, :alignment => { :horizontal=> :center })
			normal = wb.styles.add_style(:sz => 10)

			wb.add_worksheet(:name => 'Basic') do |sheet|
				sheet.add_row ["Folio","Nombre","Fecha Emisión","Moneda","Importe Asegurado","Cuota Base","Prima Neta","Gastos Expedición","IVA","Total IVA","Prima Total"], :style => headers
				row = 1

				collection.each do |rec|
					row += 1
					moneda_name = ListasGenerales::getNombreMoneda(rec.moneda)
					
					sheet.add_row [rec.num_constancia, rec.nombre, rec.emission_date, moneda_name, rec.importe, rec.base_fee/100, "=E#{row}*F#{row}", rec.expedition_fee, rec.iva/100, "=(G#{row}+H#{row})*I#{row}", "=G#{row}+H#{row}+J#{row}"], 
					:style => [normal,normal,date,moneda,currency,percent,currency,currency,percent,currency,currency]
				end
			end
		end
		
		send_data p.to_stream.read, :filename => 'rpt_emitidos.xlsx', :disposition => "attachment"
	end

	def render_xls_canceled(collection)
		p = Axlsx::Package.new
		p.workbook do |wb|
			# -- formatos
			headers  = wb.styles.add_style(:b => true, :sz => 9, :alignment => { :horizontal=> :center } )
			percent  = wb.styles.add_style(:format_code => "0.00%", :sz => 10)
			currency = wb.styles.add_style(:format_code => "$#,0.00", :sz => 10)
			date   = wb.styles.add_style(:format_code => "dd/mm/yyyy", :alignment => { :horizontal=> :center })
			moneda = wb.styles.add_style(:sz => 10, :alignment => { :horizontal=> :center })
			normal = wb.styles.add_style(:sz => 10)
			
			wb.add_worksheet(:name => 'Basic') do |sheet|
				sheet.add_row ["Folio","Nombre","Fecha Cancelación","Moneda","Importe Asegurado","Cuota Base","Prima Neta","Gastos Expedición","IVA","Total IVA","Prima Total"], :style => headers
				row = 1

				collection.each do |rec|
					row += 1
					moneda_name = ListasGenerales::getNombreMoneda(rec.moneda)
					
					sheet.add_row [rec.num_constancia, rec.nombre, rec.canceled_at, moneda_name, rec.importe, rec.base_fee/100, "=E#{row}*F#{row}", rec.expedition_fee, rec.iva/100, "=(G#{row}+H#{row})*I#{row}", "=G#{row}+H#{row}+J#{row}"], 
					:style => [normal,normal,date,moneda,currency,percent,currency,currency,percent,currency,currency]
				end
			end
		end
		
		send_data p.to_stream.read, :filename => 'rpt_cancelados.xlsx', :disposition => "attachment"
	end

	def get_report_data(params)
		response = false
		fec_ini = params[:date_start]
		fec_fin = params[:date_end]
		insurance = params[:insurance] || 0
		policy = params[:policy] || 0
		if fec_ini and fec_fin
			if params[:type_rpt] == '1'  # Emitidos
				response = CertificateRequest.unscoped.rpt_emitted(fec_ini,fec_fin,insurance,policy)
			end
			if params[:type_rpt] == '2'  # Cancelados
				response = CertificateRequest.unscoped.rpt_canceled(fec_ini,fec_fin,insurance,policy)
			end
		end
		return response
	end

end
