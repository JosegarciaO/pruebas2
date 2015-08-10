module ApiV1::CertificateRequestClause
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :certificate_request_id
      t.add :clause_id
      t.add :is_included
      t.add :is_fixed
    end

    api_accessible :list, :extend => :base do |t|
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
