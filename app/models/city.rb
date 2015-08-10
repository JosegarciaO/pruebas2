class City < ActiveRecord::Base
  attr_accessible :name, :state_id
  belongs_to :state
  has_many  :certificate_request, :dependent => :restrict

  default_scope joins(:state).order("states.name, cities.name").select("cities.*")

  scope :search, lambda { |search| 
    where("cities.name LIKE ? OR states.name LIKE ?", "%#{search}%", "%#{search}%")  if search != ''
  }

  validates :name, :presence => true, :uniqueness => { :scope => :state_id }
  validates :state_id, :presence => true

  acts_as_api
  include ApiV1::City

  def self.getState(id_ciudad)
  	self.find(id_ciudad).state
  end

  def self.getCity(id_ciudad)
  	self.find(id_ciudad)
  end

end
