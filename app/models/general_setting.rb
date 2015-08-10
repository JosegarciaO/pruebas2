class GeneralSetting < ActiveRecord::Base
  attr_accessible :iva, :base_fee_min, :packaging_default, :exchange_usd, :medidas_seguridad_default, 
  :deducible_default, :certificate_consecutive

  validates :iva, :presence => true, :numericality => { :greater_than => 0, :less_than => 100 }
  validates :base_fee_min, :presence => true, :numericality => { :greater_than => 0, :less_than => 100 }
  validates :exchange_usd, :presence => true, :numericality => { :greater_than => 0 }
  validates :certificate_consecutive, :presence => true, :numericality => true
  validate :acceptsUniqueRecord

  acts_as_api
  include ApiV1::GeneralSetting

  
  def self.getBaseFeeMin
    if rec = GeneralSetting.first
      rec.base_fee_min
    else
      0
    end
  end

  def self.getIVA
    if rec = GeneralSetting.first
      rec.iva
    else
      0
    end
  end

  def self.getPackagingDefault
    if rec = GeneralSetting.first
      rec.packaging_default
    else
      ''
    end
  end

  def self.getTipoCambio
    if rec = GeneralSetting.first
      rec.exchange_usd
    else
      1
    end
  end

  def self.getMedidasSeguridadDefault
    if rec = GeneralSetting.first
      rec.medidas_seguridad_default
    else
      ""
    end
  end

  def self.get_deducible_default
    if rec = GeneralSetting.first
      rec.deducible_default
    else
      ""
    end
  end

  def self.next_certificate_consecutive
    if rec = GeneralSetting.first
      next_cert = rec.certificate_consecutive += 1
      rec.save
    end
    next_cert ||= false
  end

  
  private 

  def acceptsUniqueRecord
    if GeneralSetting.count > 0 and !self.id
  		errors[:base] << "Ya existe un registro de configuraciones generales"
  	end
  end

end
