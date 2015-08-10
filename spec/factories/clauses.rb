# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clause do

    factory :clause_bodega do
      name "Bodega a Bodega"
      isfixed false
      active true
    end

  end
end
