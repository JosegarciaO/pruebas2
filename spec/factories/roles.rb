# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
  	name "ADMINISTRADOR"
	permalink "admin"

  	factory :admin_role do 
  		name "ADMINISTRADOR"
		permalink "admin"
  	end

  	factory :supervisor_role do
  		name "SUPERVISOR"
		permalink "supervisor"
  	end
  end
end
