module ApiV1::PossessionDescription
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add :possession_id
    end

    api_accessible :list, :extend => :base do |t|
      t.add :possession, :template => :base
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
