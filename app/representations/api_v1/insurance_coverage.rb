module ApiV1::InsuranceCoverage
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :insurance_id
      t.add :coverage_id
      t.add :deductible_min
      t.add lambda { |c| c.coverage.name }, :as => :coverage_name
      t.add lambda { |c| true }, :as => :apply
    end

    api_accessible :list, :extend => :base do |t|
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
