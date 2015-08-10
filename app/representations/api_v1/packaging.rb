module ApiV1::Packaging
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :name
    end

    api_accessible :list, :extend => :base do |t|
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
