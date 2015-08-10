class CertificateRequestClause < ActiveRecord::Base
  attr_accessible :is_included, :certificate_request_id, :clause_id, :is_fixed

  belongs_to :certificate_request
  belongs_to :clause

  validates :clause_id, :presence => true, :uniqueness => { :scope => :certificate_request_id }

  acts_as_api
  include ApiV1::CertificateRequestClause

end
