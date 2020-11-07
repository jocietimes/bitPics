require 'rails_helper'

RSpec.describe BitsController, type: :controller do
    describe "bits#show action" do
        it "should successfully show the page if the bit is found" do
            bit = FactoryBot.create(:bit)
            get :show, params: { id: bit.id }
            expect(response).to have_http_status(:success)
        end

        it "should retunr a 404 error if the bit is not found" do
            get :show, params: { id: 'TACOCAT' }
            expect(response).to have_http_status(:not_found)
        end
    end
    
    describe "bits#index action" do
        it "should successfully show the page" do
            get :index
            expect(response).to have_http_status(:success)
        end
    end

    describe "bits#new action" do
        it "should require users to be logged in" do
            get :new
            expect(response).to redirect_to new_user_session_path
        end

        it "should sucessfully show the new form" do
            user = FactoryBot.create(:user)
            sign_in user
        

            get :new
            expect(response).to have_http_status(:success)
        end
    end

    describe "bits#create action" do
        it "should require users to be logged in" do
            post :create, params: {bit: { message: 'Hello!'} }
            expect(response).to redirect_to new_user_session_path
        end

        it "should successfully create a new bit in our database" do
            user = FactoryBot.create(:user)
            sign_in user

            post :create, params: {bit: { message: 'Hello!'} }
            expect(response).to redirect_to root_path

            bit = Bit.last
            expect(bit.message).to eq("Hello!")
            expect(bit.user).to eq(user)
        end

        it "should properly deal with validation errors" do
            user = FactoryBot.create(:user)
            sign_in user

            bit_count = Bit.count
            post :create, params: { bit: {message: ''} }
            expect(response).to have_http_status(:unprocessable_entity)
            expect(bit_count).to eq Bit.count
        end
    end 
end
