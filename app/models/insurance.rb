class Insurance < ActiveRecord::Base
  attr_accessible :name, :expedition_fee_mx, :expedition_fee_us, :logo, :firma1, :firma2, :max_amount, :deductible_text, :insurance_possessions_attributes,
    :street, :area, :zip_code, :city_id, :tin, :annexes_attributes, :insurance_coverages_attributes

  has_attached_file :logo,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"
  has_attached_file :firma1,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"
  has_attached_file :firma2,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"

  has_many :policies, :dependent => :restrict
  has_many :insurance_possessions, :dependent => :destroy
  has_many :insurance_coverages, :dependent => :destroy
  has_many :annexes
  has_many :coverages, :through => :insurance_coverages

  belongs_to :city

  accepts_nested_attributes_for :insurance_possessions
  accepts_nested_attributes_for :insurance_coverages, :reject_if => proc { |attributes| !attributes['apply'].eql?('1') && !attributes['_destroy'].eql?('1') }, :allow_destroy => true
  accepts_nested_attributes_for :annexes

  validates_attachment_content_type :logo, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'Tipo de acrhivo no permitido (solo imagenes jpeg/png/gif)'
  validates_attachment_content_type :firma1, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'Tipo de acrhivo no permitido (solo imagenes jpeg/png/gif)'
  validates_attachment_content_type :firma2, :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'Tipo de acrhivo no permitido (solo imagenes jpeg/png/gif)'

  validates :name, :presence => true, :uniqueness => true
  validates :tin, :street, :area, :zip_code, :city_id, :presence => true
  validates :expedition_fee_mx, :presence => true, :numericality => { :greater_than => 0 }
  validates :expedition_fee_us, :presence => true, :numericality => { :greater_than => 0 }
  validates :max_amount, :presence => true, :numericality => { :greater_than => 0 }

  acts_as_api
  include ApiV1::Insurance

  def self.build_object
    new.tap do |r|
      r.insurance_possessions.build
      r.insurance_coverages.build
      r.annexes.build
    end
  end

end
