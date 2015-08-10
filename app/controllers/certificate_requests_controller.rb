class CertificateRequestsController < InheritedResources::Base
  before_filter :getCatalogos, :only => :index
  include BackboneResponses
  load_and_authorize_resource :except => [:print]
  respond_to :json


  def index  # -- Override a INDEX para pasar el usuario
    instance_variable_set("@#{controller_name}" , resources_with_pagination(collection.by_role(current_user.id).by_status(params[:status] || 0).search(params[:search] || '')))
    respond_to do |format|
      format.html
      format.json { render :json => instance_variable_get("@#{controller_name}") }
    end
  end


  def print
    id_certificado = params[:id]
    if id_certificado and @certif = CertificateRequest.find(id_certificado)
      respond_to do |format|
        format.pdf {
          send_data render_to_string, filename: "CertificateRequest_#{id_certificado}.pdf", type: 'application/pdf', disposition: 'attachment'
        }
      end
    else
      redirect_to 'certificate_requests_path'
    end
  end

  def setAuthorizeCertificate
    res = false
    #byebug
    if params[:id] and certificado = CertificateRequest.find(params[:id])
      res = certificado.setAutorizar
    end
    respond_to do |format|
      format.json { render :json => res }
    end
  end

  def setSealCertificate
    res = false
    if params[:id] and certificado = CertificateRequest.find(params[:id])
      res = certificado.setEmitir
    end
    respond_to do |format|
      format.json { render :json => res }
    end
  end

  def setCancelCertificate
    res = false
    if params[:id] and certificado = CertificateRequest.find(params[:id])
      res = certificado.setCancel
    end
    respond_to do |format|
      format.json { render :json => res }
    end
  end


  private

  def getCatalogos
    @countries = Country.all
    @all_status = ListasGenerales::get_all_status
  	@monedas = ListasGenerales::getMonedas
    @bienes  = Possession.actives
    @cuota_base_min = GeneralSetting::getBaseFeeMin
    @iva = GeneralSetting::getIVA
    @packaging_default = GeneralSetting::getPackagingDefault
    @medida_seguridad = GeneralSetting::getMedidasSeguridadDefault
    @deducible_default = GeneralSetting::get_deducible_default
  end

end

