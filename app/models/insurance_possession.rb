class InsurancePossession < ActiveRecord::Base
  belongs_to :insurance
  belongs_to :possession
  attr_accessible :has_max_amount, :max_amount, :insurance_id, :possession_id

  validates :max_amount, :presence => true, :numericality => { :greater_than => 0 }
  validates :insurance_id, :presence => true
  validates :possession_id, :presence => true, :uniqueness => { :scope => [:insurance_id] }

  acts_as_api
  include ApiV1::InsurancePossession

end
