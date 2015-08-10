module ApiV1::Insurance
  extend ActiveSupport::Concern

  included do

    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add :tin
      t.add :street
      t.add :area
      t.add :city_id
      t.add lambda { |c| c.city ? c.city.state_id : nil }, :as => :state_id
      t.add :zip_code
      t.add :expedition_fee_mx
      t.add :expedition_fee_us
      t.add lambda{|u| u.logo.url},   :as => :logo
      t.add lambda{|u| u.firma1.url}, :as => :firma1
      t.add lambda{|u| u.firma2.url}, :as => :firma2
      t.add :max_amount
      t.add :deductible_text
    end

    api_accessible :list, :extend => :base do |t|
      t.add :insurance_possessions
      t.add :insurance_coverages
      t.add :annexes
    end

    api_accessible :public, :extend => :list do |t|
    end

  end

end
