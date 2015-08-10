class Possession < ActiveRecord::Base
  attr_accessible :name, :active, :has_max_amount, :max_amount
  
  has_many :certificate_requests, :dependent => :restrict
  has_many :insurance_possessions, :dependent => :destroy

  default_scope order(:name)

  validates :name, :presence => true, :uniqueness => true
  validates :max_amount, :presence => true, :numericality => true
  validate :validateMaxAmount

  acts_as_api
  include ApiV1::Possession

  scope :actives, where(:active => true)

  
  def self.getSumaAseguradaMax(id, poliza_id)
    suma_aseg_max = nil

    if possesion = self.find(id)
      insurance = Policy.find(poliza_id).insurance
      
      # -- primero buscar en insurance_possessions (bienes por aseguradora)
      if rec = insurance.insurance_possessions.where(:possession_id => id) and rec.count > 0
        suma_aseg_max = rec.first.max_amount

      # -- sino hay, buscar en possessions (bienes)
      elsif possesion.has_max_amount and possesion.max_amount > 0
        suma_aseg_max = possesion.max_amount

      # -- de lo contrario, buscar en insurance (aseguradora)
      else
        suma_aseg_max = insurance.max_amount
      end

    end

    return suma_aseg_max
  end
  
  private

  def validateMaxAmount
  	if self.has_max_amount and self.max_amount and self.max_amount <= 0
  		errors.add(:max_amount, "no puede estar en 0")
  	end
  end

end
