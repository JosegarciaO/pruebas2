module ApiV1::CertificateRequestCoverage
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :certificate_request_id
      t.add :coverage_id
      t.add :incluir
      t.add :deductible
    end

    api_accessible :list, :extend => :base do |t|
      # t.add :coverage
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
