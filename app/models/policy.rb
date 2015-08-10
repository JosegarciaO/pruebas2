# -*- coding: utf-8 -*-

class Policy < ActiveRecord::Base
  attr_accessible :folio, :moneda, :insurance_id, :date_start, :date_end
  
  belongs_to :insurance
  has_many :certificate_requests, :dependent => :restrict

  validates :folio, :presence => true, :uniqueness => true
  validates :moneda, :presence => true
  validates :insurance_id, :presence => true
  validates :date_start, :presence => true
  validates :date_end, :presence => true

  validate :validarFechas

  default_scope order("date_start DESC")

  scope :by_insurance, lambda { |insurance|
    where(:insurance_id => insurance).order("date_start DESC")
  }

  acts_as_api
  include ApiV1::Policy

  def self.getPoliciesByCurrency(id_moneda,id_poliza)
  	if id_poliza.to_i != 0
  		self.where(:id => id_poliza)
  	else
      hoy = Date.today
  		self.where(['date_start <= ? AND date_end >= ? AND moneda = ? ',hoy, hoy, id_moneda])
  	end
  end

  def self.getGastosExpedicion(poliza)
    importe = 0
    if poliza = self.find(poliza)
      case poliza.moneda
      when 'M'
        importe = poliza.insurance.expedition_fee_mx
      when 'U'
        importe = poliza.insurance.expedition_fee_us
      end
    end
    importe
  end

  def esActiva?
    Date.today >= self.date_start and Date.today <= self.date_end
  end


  private

  def validarFechas
    if self.date_start and self.date_end
      if self.date_start > self.date_end
        errors.add(:date_start, "no pueder ser mayor a Fin de Vigencia")
      end
    end

    # validar que date_start no esté en el rango de alguna otra poliza
    if self.date_start and fechaEnRangoPoliza?(self.date_start)
      errors.add(:date_start, "coincide con el rango de alguna otra póliza")
    end

    # validar que date_end no esté en el rango de alguna otra poliza
    if self.date_end  and fechaEnRangoPoliza?(self.date_end)
      errors.add(:date_end, "coincide con el rango de alguna otra póliza")
    end

    if errors.count == 0 and abarcaRangosPolizas?
      errors.add(:date_start, " y Fin de Vigencia abarca el rango de otra póliza")
    end
  end

  def fechaEnRangoPoliza? (date)
    regs = 0
    if self.moneda and self.insurance_id
      if self.id
        regs = Policy.where(['? >= date_start AND ? <= date_end AND moneda = ? AND insurance_id = ? AND id != ?',date, date, self.moneda, self.insurance_id, self.id]).count
      else
        regs = Policy.where(['? >= date_start AND ? <= date_end AND moneda = ? AND insurance_id = ?',date, date, self.moneda, self.insurance_id]).count
      end
    end
    regs > 0  # esta dentro del rango de otra poliza
  end

  def abarcaRangosPolizas?
    regs = 0
    if self.date_start and self.date_end and self.moneda and self.insurance_id
      if self.id
        regs = Policy.where(['? < date_start AND ? > date_end AND moneda = ? AND insurance_id = ? AND id != ?', self.date_start, self.date_end, self.moneda, self.insurance_id, self.id]).count
      else
        regs = Policy.where(['? < date_start AND ? > date_end AND moneda = ? AND insurance_id = ?', self.date_start, self.date_end, self.moneda, self.insurance_id]).count
      end
    end
    regs > 0
  end

end