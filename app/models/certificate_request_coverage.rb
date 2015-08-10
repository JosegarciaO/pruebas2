# -*- coding: utf-8 -*-

class CertificateRequestCoverage < ActiveRecord::Base
  attr_accessible :certificate_request_id, :coverage_id, :incluir, :deductible

  belongs_to :certificate_request
  belongs_to :coverage
  
  validates :coverage_id, :presence => true, :uniqueness => { :scope => :certificate_request_id }
  validates :deductible, :presence => true, :numericality => { :greater_than => 0, :less_than => 100 }

  validate :minimoCoberturaDeducible

  acts_as_api
  include ApiV1::CertificateRequestCoverage 

  private

  def minimoCoberturaDeducible
    if self.deductible and self.coverage_id and self.deductible < self.coverage.deductible_min
      errors[:base] << "Deducible menor al mínimo"
  	end
  end

end
