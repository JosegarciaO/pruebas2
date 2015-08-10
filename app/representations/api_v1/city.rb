module ApiV1::City
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add :state_id
      t.add lambda { |c| c.state.country.id }, :as => :country_id
    end

    api_accessible :list, :extend => :base do |t|
      t.add :state
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
