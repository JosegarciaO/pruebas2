class Country < ActiveRecord::Base
  attr_accessible :name
  has_many :states, :dependent => :restrict

  default_scope order(:name)

  validates :name, :presence => true, :uniqueness => true

  acts_as_api
  include ApiV1::Country

end
