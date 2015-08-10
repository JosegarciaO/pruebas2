# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :user do
		email "luis.lomeli@mail.com"
		password "ab123456"
		password_confirmation "ab123456"

		factory :admin_user do
			after(:build) do |user|
				user.role = FactoryGirl.create(:admin_role)
			end
		end

		factory :supervisor_user do
			after(:build) do |user|
				user.role = FactoryGirl.create(:supervisor_role)
			end
		end

	end
end
