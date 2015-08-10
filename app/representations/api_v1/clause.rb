module ApiV1::Clause
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add :isfixed
      t.add :active
    end

    api_accessible :list, :extend => :base do |t|
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
