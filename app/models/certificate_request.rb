# -*- coding: utf-8 -*-

class CertificateRequest < ActiveRecord::Base

  before_create :asigns_user
  before_save :add_fixed_clauses

  attr_accessible :num_constancia, :nombre, :direccion, :city_id, :cp, :rfc, :fecha_salida, :fecha_llegada, :importe, :base_fee,
  :expedition_fee, :iva, :iva_amount, :total_prime, :moneda, :beneficiario, :deducibles, :medida_seguridad, :possession_id,
  :codigo_seguridad, :status, :cancelado, :user_id, :policy_id, :use_beneficiario, :city_from_id, :city_to_id,
  :possession_description, :packaging, :same_city, :num_invoice, :emission_date, :transport_ground, :transport_air,
  :transport_maritime, :transport_rail, :transport_package, :certificate_request_coverages_attributes,
  :certificate_request_clauses_attributes, :transportation_ids

  has_many :certificate_request_coverages, :dependent => :destroy
  has_many :coverages, :through => :certificate_request_coverages
  has_many :certificate_request_clauses, :dependent => :destroy
  has_many :clauses, :through => :certificate_request_clauses
  belongs_to :city
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"
  belongs_to :possession
  belongs_to :user
  belongs_to :policy

  has_and_belongs_to_many :transportations

  default_scope order("id DESC")

  scope :by_role, lambda { |id_usuario|
    if id_usuario and user = User.find(id_usuario)
      where(:user_id => user.id) if user.aduana?
    end
  }

  scope :by_status, lambda { |status|
    where(:status => status) if status.to_s != '0'
  }

  scope :search, lambda { |search|
    where("num_constancia = ? OR nombre LIKE ?", search, "%#{search}%")  if search != ''
    #byebug
  }

  scope :rpt_emitted, lambda { |date_start,date_end,insurance,policy|
    select("num_constancia,nombre,emission_date,certificate_requests.moneda,importe,base_fee,expedition_fee,
            iva,iva_amount,total_prime,certificate_requests.created_at,canceled_at")
    .joins("LEFT JOIN policies ON certificate_requests.policy_id = policies.id")
    .where(:emission_date => (date_start.to_date)..(date_end.to_date), :cancelado => false)
    .by_insurance(insurance)
    .by_policy(policy)
    .order("num_constancia")
  }

  scope :rpt_canceled, lambda { |date_start,date_end,insurance,policy|
    select("num_constancia,nombre,emission_date,certificate_requests.moneda,importe,base_fee,expedition_fee,
            iva,iva_amount,total_prime,certificate_requests.created_at,canceled_at")
    .joins("LEFT JOIN policies ON certificate_requests.policy_id = policies.id")
    .where(:canceled_at => (date_start.to_date)..(date_end.to_date), :cancelado => true)
    .by_insurance(insurance)
    .by_policy(policy)
    .order("num_constancia")
  }

  scope :by_policy, lambda { |policy|
    where(:policy_id => policy) if policy.to_i > 0
  }

  scope :by_insurance, lambda { |insurance|
    where("policies.insurance_id = ?", insurance) if insurance.to_i > 0
  }


  accepts_nested_attributes_for :certificate_request_coverages, :certificate_request_clauses

  validates :num_constancia, :uniqueness => true, if: :num_constancia?
  validates :nombre, :presence => true
  validates :direccion, :presence => true
  validates :city_id, :presence => true
  validates :cp, :presence => true, :format => { :with => /^[0-9]{5,6}$/ }
  validates :rfc, :presence => true, :format => { :with => /^[A-Z]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z0-9]{3}$/ }
  validates :fecha_salida, :presence => true
  validates :importe, :presence => true, :numericality => { :greater_than => 0 }
  validates :num_invoice, :presence => true

  validates :moneda, :presence => true
  validates :possession_id, :presence => true
  validates :city_from_id, :presence => true
  validates :city_to_id, :presence => true
  validates_associated :certificate_request_coverages

  validate :validarFechas
  validate :sumaAseguradaMaxima
  validate :configuracionesGenerales
  validate :validate_quotation
  validate :validate_transportation

  acts_as_api
  include ApiV1::CertificateRequest

  def self.build_object
    new.tap do |c|
      c.certificate_request_coverages.build
      c.certificate_request_clauses.build
    end
  end

  # -- Manejo de status de la solicitud
  def statusSolicitado?
    self.status == 1
  end

  def statusCotizado?
    self.status == 2
  end

  def statusAutorizado?
    self.status == 3
  end

  def statusEmitido?
    self.status == 4
  end

  def statusCancelado?
    self.cancelado == true
  end

  def setAutorizar
    if self.statusCotizado?
      self.status = 3
      self.save
    else
      false
    end
  end

  def setEmitir
    if self.statusAutorizado? and self.generate_certificate? and self.valid?
      self.status = 4
      self.emission_date = Date.current()
      self.codigo_seguridad = self.getCodigoSeguridad
      self.save
    else
      false
    end
  end

  def setCancel
    if self.statusCancelado?
      false
    else
      self.cancelado = true
      self.canceled_at = Date.current()
      self.save
    end
  end


  def getDomicilio
    self.direccion + '; ' + self.city.name.capitalize + ', ' + self.city.state.name.capitalize + ', ' + self.city.state.country.name.capitalize
  end

  def get_text_coverages
    texto = ''
    primero = true
    self.certificate_request_coverages.each do |det|
      if det[:incluir]
        texto += ', ' unless primero
        texto += det.coverage.name + " (" + det[:deductible].to_s() + "%)"
        primero = false
      end
    end
    texto += '.'
  end

  def get_text_clauses
    texto = ''
    primero = true
    self.clauses.uniq.each do |det|
      texto += ', ' unless primero
      texto += det.name
      primero = false
    end
    texto += '.'
  end

  def get_transportation_text
    self.transportations.collect(&:name).join(', ')
  end

  def getCodigoSeguridad
    cadena = self.num_constancia.to_s.strip
    cadena += "|" + self.moneda.to_s.strip
    cadena += "|" + self.importe.to_s.strip
    cadena += "|" + self.total_prime.to_s.strip
    cadena += "|" + self.policy_id.to_s.strip
    cadena += "|" + self.nombre.to_s.strip
    cadena += "|" + self.rfc.to_s.strip
    cadena += "|" + self.direccion.to_s.strip
    cadena += "|" + self.city_id.to_s.strip
    cadena += "|" + self.cp.to_s.strip
    cadena += "|" + self.possession_id.to_s.strip
    cadena += "|" + self.possession_description.to_s.strip
    cadena += "|" + self.packaging.to_s.strip
    cadena += "|" + self.city_from_id.to_s.strip
    cadena += "|" + self.city_to_id.to_s.strip
    cadena += "|" + self.transport_ground.to_s.strip
    cadena += "|" + self.transport_air.to_s.strip
    cadena += "|" + self.transport_maritime.to_s.strip
    cadena += "|" + self.transport_rail.to_s.strip
    cadena += "|" + self.transport_package.to_s.strip
    cadena += "|" + self.fecha_salida.to_s.strip
    cadena += "|" + self.fecha_llegada.to_s.strip
    cadena += "|" + self.num_invoice.to_s.strip
    cadena += "|" + self.beneficiario.to_s.strip

    self.certificate_request_coverages.each do |det|
      cadena += "|" + det.coverage_id.to_s
    end

    digest = Digest::SHA1.hexdigest(cadena)
    return Base64.encode64(digest)
  end

  def esCodSeguridadCorrecto?
    self.codigo_seguridad == self.getCodigoSeguridad
  end

  def getBeneficiario
    if self.use_beneficiario
      self.beneficiario
    else
      "N/A"
    end
  end

  def getPrimaNeta
    self.importe * (self.base_fee/100)
  end

  def generate_certificate?
    # Por el momento al num. de constancia/certificado se genera de la siguiente manera:
    # -> La letra A
    # -> La letra segun la moneda seleccionada (M/U)
    # -> Un guion (-)
    # -> El consecutivo del certificado formateado a: 00005
    if next_cert = GeneralSetting::next_certificate_consecutive
      self.num_constancia = "A" + self.moneda + '-' + ("%05d" % next_cert)
      true
    else
      false
    end
  end


  private

  def asigns_user
    self.user_id = Thread.current[:user_id]
  end

  def add_fixed_clauses
    fixed_clauses = self.transportations.collect(&:clauses).sum

    fixed_clauses.uniq.each do |clause|
      self.certificate_request_clauses.build(:clause_id => clause.id, :is_fixed => true, :is_included => true)
    end if fixed_clauses.is_a?(Array)
  end

  def validate_quotation
    # -- si cambio la cuota base, esta cotizando
    
    if self.base_fee and self.base_fee > 0 and self.base_fee != self.base_fee_was
      validates_min_base_fee
      validates_comments
      validates_coverages
      byebug
      validates_clauses
      validates_policy
byebug
      self.status = 2
      calculate_totals
    end
  end

  def validate_transportation
    errors[:base] << "Favor de agregar un medio de transporte" if self.transportations.empty?
  end

  def calculate_totals
    if self.policy_id
      prima_neta = getPrimaNeta
      self.expedition_fee = Policy::getGastosExpedicion(self.policy_id)
      self.iva = GeneralSetting::getIVA
      self.iva_amount = (prima_neta + self.expedition_fee) * (self.iva/100)
      self.total_prime = prima_neta + self.expedition_fee + iva_amount
    end
  end

  def validarFechas
    if !self.id and self.fecha_salida
      # A petición de Orbe (ticket #3850) se elimina la validación
      # si es nuevo registro, fecha de salida no puede antes al dia de hoy
      
       if (self.new_record? and self.fecha_salida < Date.current()) and $user.role_id != 1
         errors.add(:fecha_salida, "no pueder ser anterior al dia de hoy")
       end

      if self.fecha_llegada and self.fecha_salida > self.fecha_llegada
        errors.add(:fecha_salida, "no pueder ser mayor a la fecha de llegada")
      end
    end
  end

  def validates_min_base_fee
    min_base_fee = GeneralSetting::getBaseFeeMin
    if self.base_fee and self.base_fee < min_base_fee
      errors.add(:base_fee, "no pueder ser menor a " + min_base_fee.to_s())
    end
  end

  def validates_coverages
    if self.certificate_request_coverages.size == 0
      errors[:base] << "Favor de agregar coberturas"
    end
  end

  def validates_clauses
    if self.certificate_request_clauses.size == 0
      errors[:base] << "Favor de agregar clausulas"
    end
    #byebug
  end

  def validates_comments
    if !self.deducibles
      errors.add(:deducibles, "no debe estar en blanco")
    end
  end

  def validates_policy
    byebug
    if !self.policy_id
      errors.add(:policy_id, "no debe estar en blanco")
    end
  end

  def sumaAseguradaMaxima
    if self.possession_id and self.policy_id and self.importe and self.moneda
      sum_aseg_max = Possession::getSumaAseguradaMax(self.possession_id, self.policy_id) || 0

      if self.moneda == 'U'  # si la moneda es dolares, realizar la conversion
        sum_aseg_max = sum_aseg_max / GeneralSetting::getTipoCambio
      end

      if self.importe > sum_aseg_max
        sum_aseg_max_texto = sum_aseg_max.round(2)
        errors.add(:importe, "no debe ser mayor a #{sum_aseg_max_texto} (Aseguradora ó Bienes)")
      end
    end
  end

  def configuracionesGenerales
    if !settings = GeneralSetting.first
      errors[:base] << "Favor de especificar las configuraciones generales"
    end
  end

end
