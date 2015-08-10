class Role < ActiveRecord::Base
	attr_accessible :name, :permalink
	has_many :users

	validates :name, :presence => true, :uniqueness => true
	validates :permalink, :presence => true, :uniqueness => true

	acts_as_api
	include ApiV1::Role

end
