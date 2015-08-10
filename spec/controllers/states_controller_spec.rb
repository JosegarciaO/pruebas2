require 'spec_helper'

describe StatesController do
	
	describe 'Administrator Access' do
		before :each do
			@state = FactoryGirl.create(:state_jalisco, name:'JALISCO')
			@user = FactoryGirl.create(:admin_user)
			sign_in @user
		end

		describe "GET #index" do
			it "Renders the :index view" do
				get :index
				expect(response).to render_template :index
			end
		end

		describe "GET #show" do
			it "Renders the :show view" do
				get :show, id: @state
				expect(assigns(:state)).to eq @state
			end
		end
	end

	# describe 'Supervisor Access' do
	# 	before :each do
	# 		@state = FactoryGirl.create(:state, name:'JALISCO')
	# 		@user = FactoryGirl.create(:supervisor_user)
	# 		sign_in @user
	# 	end

	# 	describe "GET #index" do
	# 		it "Redirect to home page" do
	# 			get :index
	# 			expect(response).to eq(302)
	# 		end
	# 	end
	# end

end