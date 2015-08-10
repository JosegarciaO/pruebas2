class State < ActiveRecord::Base
	attr_accessible :name, :country_id
	has_many :cities, :dependent => :restrict
	belongs_to :country
	
	default_scope joins("LEFT JOIN countries ON countries.id = states.country_id").order("countries.id, states.name").select("states.*")

	validates :name, :presence => true, :uniqueness => true 
	validates :country_id, :presence => true

	acts_as_api
	include ApiV1::State
	
end
