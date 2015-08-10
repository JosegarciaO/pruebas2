require 'spec_helper'

describe User do
	it "Allows build a new User model" do
		expect(FactoryGirl.build(:admin_user)).to be_valid
	end

	it "Is invalid with a duplicate email address" do
		FactoryGirl.create(:admin_user)
		user = User.new(email:'luis.lomeli@mail.com', password:'ab123456', password_confirmation:'ab123456')
		expect(user).to have(1).errors_on(:email)
	end

	it "Is invalid without a Role" do
		user = FactoryGirl.build(:user)
		expect(user).to have(1).errors_on(:role_id)
	end
end
