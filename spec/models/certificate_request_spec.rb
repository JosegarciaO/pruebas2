require 'spec_helper'

describe CertificateRequest do
	# before :each do
	# 	@cualsi_request = FactoryGirl.build(:cualsi_request)
	# end

	# subject{ @cualsi_request }


	it "Allows build a new CertificateRequest model" do
		expect(FactoryGirl.build(:cualsi_request)).to be_valid
	end

	it "Is invalid without Nombre" do 
		req = FactoryGirl.build(:cualsi_request, nombre: nil)
		expect(req).to have(1).errors_on(:nombre)
	end 

	it "Is invalid without Direccion" do 
		# subject.direccion = nil
		# expect(subject).to have(1).errors_on(:direccion)
		req = FactoryGirl.build(:cualsi_request, direccion: nil)
		expect(req).to have(1).errors_on(:direccion)
	end

	it "Is invalid without C.P." do
		req = FactoryGirl.build(:cualsi_request, cp: nil)
		expect(req).to have_at_least(1).errors_on(:cp)
	end

	it "Is invalid format for C.P." do
		req = FactoryGirl.build(:cualsi_request, cp: "AAA")
		expect(req).to have_at_least(1).errors_on(:cp)
	end

	it "Is invalid without RFC" do
		req = FactoryGirl.build(:cualsi_request, rfc: nil)
		expect(req).to have_at_least(2).errors_on(:rfc)
	end

	it "Is invalid format 1 for RFC" do
		req = FactoryGirl.build(:cualsi_request, rfc: "LOML")
		expect(req).to have_at_least(1).errors_on(:rfc)
	end

	it "Is invalid format 2 for RFC" do
		req = FactoryGirl.build(:cualsi_request, rfc: "LOML800915")
		expect(req).to have_at_least(1).errors_on(:rfc)
	end

	
	it "Is invalid without Fecha Salida" do
		req = FactoryGirl.build(:cualsi_request, fecha_salida: nil)
		expect(req).to have(1).errors_on(:fecha_salida)
	end

	it "Is invalid with Fecha Salida less than today" do
		req = FactoryGirl.build(:cualsi_request, fecha_salida: Date.current() - 1)
		expect(req).to have(1).errors_on(:fecha_salida)
	end

	it "Is invalid with Fecha Salida greater than Fecha Llegada" do
		req = FactoryGirl.build(:cualsi_request, fecha_salida: Date.current() + 2)
		expect(req).to have(1).errors_on(:fecha_salida)
	end

	it "Is invalid without Importe" do
		req = FactoryGirl.build(:cualsi_request, importe: nil)
		expect(req).to have_at_least(1).errors_on(:importe)
	end

	it "Is invalid with Importe equals to 0" do
		req = FactoryGirl.build(:cualsi_request, importe: 0)
		expect(req).to have_at_least(1).errors_on(:importe)
	end

	it "Is invalid with Importe less than 0" do
		req = FactoryGirl.build(:cualsi_request, importe: -1)
		expect(req).to have_at_least(1).errors_on(:importe)
	end


	# it "Is invalid without Base Fee" do
	# 	req = FactoryGirl.build(:cualsi_request, base_fee: nil)
	# 	expect(req).to have_at_least(1).errors_on(:base_fee)
	# end

	# it "Is invalid with Base Fee equals to 0" do
	# 	req = FactoryGirl.build(:cualsi_request, base_fee: 0)
	# 	expect(req).to have_at_least(1).errors_on(:base_fee)
	# end

	# it "Is invalid with Base Fee less than 0" do
	# 	req = FactoryGirl.build(:cualsi_request, base_fee: -1)
	# 	expect(req).to have_at_least(1).errors_on(:base_fee)
	# end

	# it "Is invalid with Base Fee greater than 100" do
	# 	req = FactoryGirl.build(:cualsi_request, base_fee: 101)
	# 	expect(req).to have_at_least(1).errors_on(:base_fee)
	# end

	# it "Is invalid if Base Fee is less than minimum in GeneralSettings" do
	# 	req = FactoryGirl.build(:cualsi_request, base_fee: 0.10)
	# 	expect(req).to have_at_least(1).errors_on(:base_fee)
	# end


	# it "Is invalid without Expedition Fee" do
	# 	req = FactoryGirl.build(:cualsi_request, expedition_fee: nil)
	# 	expect(req).to have_at_least(1).errors_on(:expedition_fee)
	# end

	# it "Is invalid with Expedition Fee equals to 0" do
	# 	req = FactoryGirl.build(:cualsi_request, expedition_fee: 0)
	# 	expect(req).to have_at_least(1).errors_on(:expedition_fee)
	# end

	# it "Is invalid with Expedition Fee less than 0" do
	# 	req = FactoryGirl.build(:cualsi_request, expedition_fee: -1)
	# 	expect(req).to have_at_least(1).errors_on(:expedition_fee)
	# end


	it "Is invalid without Moneda" do
		req = FactoryGirl.build(:cualsi_request, moneda: nil)
		expect(req).to have(1).errors_on(:moneda)
	end


	it "Is invalid without City" do
		req = FactoryGirl.build(:certificate_request)
		expect(req).to have(1).errors_on(:city_id)
	end

	it "Is invalid without City From" do
		req = FactoryGirl.build(:certificate_request)
		expect(req).to have(1).errors_on(:city_from_id)
	end

	it "Is invalid without City To" do
		req = FactoryGirl.build(:certificate_request)
		expect(req).to have(1).errors_on(:city_to_id)
	end


	it "Is invalid without Possession" do
		req = FactoryGirl.build(:certificate_request)
		expect(req).to have(1).errors_on(:possession_id) 
	end

	# it "Is invalid without Policy" do
	# 	req = FactoryGirl.build(:certificate_request)
	# 	expect(req).to have(1).errors_on(:policy_id) 
	# end

	it "Is invalid without Moneda" do
		req = FactoryGirl.build(:cualsi_request, moneda: nil)
		expect(req).to have(1).errors_on(:moneda)
	end

	it "Is invalid without any transportation" do
		req = FactoryGirl.build(:cualsi_request, transport_ground: false)
		expect(req).to have_at_least(1).errors_on(:base)
	end

	it "Is invalid without GeneralSettings" do
		req = FactoryGirl.build(:certificate_request)
		expect(req).to have_at_least(1).errors_on(:base)
	end

	# it "IVA is valid by calculaImportes" do
	# 	req = FactoryGirl.create(:cualsi_request)
	# 	expect(req.iva).to eq(16)
	# end

	# it "Iva Amount is valid by calculaImportes" do
	# 	req = FactoryGirl.create(:cualsi_request)
	# 	expect(req.iva_amount).to eq(39.04)
	# end

	# it "Total Prime is valid by calculaImportes" do
	# 	req = FactoryGirl.create(:cualsi_request)
	# 	expect(req.total_prime).to eq(283.04)
	# end


	# ===== Al Cotizar un Certificado =====

end
