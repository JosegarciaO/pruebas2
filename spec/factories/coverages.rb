# -*- coding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coverage do
    
  	factory :coverage_riesgo do
  		name "Riesgos Ordinarios de Transito"
  		active 1
  		deductible_min 15
  	end

  	factory :coverage_robo do
  		name "Robo Total"
  		active 0
  		deductible_min 20
  	end

  end
end
