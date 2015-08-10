module ApiV1::InsurancePossession
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :insurance_id
      t.add :possession_id
      t.add :has_max_amount
      t.add :max_amount
    end

    api_accessible :list, :extend => :base do |t|
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
