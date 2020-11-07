require 'rails_helper'

RSpec.describe BitsController, type: :controller do
    describe "bits#index action" do
        it "should successfully show the page" do
            get :index
            expect(response).to have_http_status(:success)
        end
    end

    describe "bits#new action" do
        it "should sucessfully show the new form" do
            get :new
            expect(response).to have_http_status(:success)
        end
    end

    describe "bits#create action" do
        it "should successfully create a new bit in our database" do
            post :create, params: {bit: { message: 'Hello!'} }
            expect(response).to redirect_to root_path

            bit = Bit.last
            expect(bit.message).to eq("Hello!")
        end
    end 
end
