require 'rails_helper'

RSpec.describe BitsController, type: :controller do
    describe "bits#destroy action" do
        it "shouldn't allow a user who did not create bit, destroy bit" do
            bit = FactoryBot.create(:bit)
            user = FactoryBot.create(:user)
            sign_in user
            delete :destroy, params: { id: bit.id }
            expect(response).to have_http_status(:forbidden)
        end

        it "shouldn't let unauthenticated users destroy a bit" do
            bit = FactoryBot.create(:bit)
            delete :destroy, params: { id: bit.id }
            expect(response).to redirect_to new_user_session_path
        end

        it "should allow a user to destroy bits" do
            bit = FactoryBot.create(:bit)
            sign_in bit.user
            delete :destroy, params: { id: bit.id }
            expect(response).to redirect_to root_path
            bit = Bit.find_by_id(bit.id)
            expect(bit).to eq nil
        end
        
        it "should return a 404 message if we cannot find the bit with that id" do
            user = FactoryBot.create(:user)
            sign_in user
            delete :destroy, params: { id: 'SPACEDUCK' }
            expect(response).to have_http_status(:not_found)
        end
    end

    describe "bits#update action" do
        it "shouldn't allow a user who did not create bit, update bit" do
            bit = FactoryBot.create(:bit)
            user = FactoryBot.create(:user)
            sign_in user
            patch :update, params: { id: bit.id, bit: { message: 'wahoo' } }
            expect(response).to have_http_status(:forbidden)
        end

        it "shouldn't allow unauthenticated users to update bits" do
            bit = FactoryBot.create(:bit)
            patch :update, params: { id: bit.id, bit: { message: "Hello" } }
            expect(response).to redirect_to new_user_session_path
        end

        it "should allow users to successfully update bits" do
            bit = FactoryBot.create(:bit, message: "Initial Value")
            sign_in bit.user

            patch :update, params: { id: bit.id, bit: { message: 'Changed'} }
            expect(response).to redirect_to root_path
            bit.reload
            expect(bit.message).to eq "Changed"
        end

        it "should have http 404 error if the bit cannot be found" do
            user = FactoryBot.create(:user)
            sign_in user
            patch :update, params: { id: "YOLOSWAG", bit: { message: 'Changed'} }
            expect(response).to have_http_status(:not_found)
        end

        it "should render the edit form with an http status of unprocessable_entity" do
            bit = FactoryBot.create(:bit, message: "Initial Value")
            sign_in bit.user
            patch :update, params: { id: bit.id, bit: { message: ''} }
            expect(response).to have_http_status(:unprocessable_entity)
            bit.reload
            expect(bit.message).to eq "Initial Value"
        end
    end

    describe "bits#edit action" do
        it "shouldn't allow a user who did not create bit, edit bit" do
            bit = FactoryBot.create(:bit)
            user = FactoryBot.create(:user)
            sign_in user
            get :edit, params: { id: bit.id }
            expect(response).to have_http_status(:forbidden)
        end

        it "shouldn't allow unauthenticated users to edit bits" do
            bit = FactoryBot.create(:bit)
            patch :update, params: { id: bit.id }
            expect(response).to redirect_to new_user_session_path
        end

        it "should successfully show the edit form if the bit is found" do
            bit = FactoryBot.create(:bit)
            sign_in bit.user

            get :edit, params: { id: bit.id }
            expect(response).to have_http_status(:success)
        end

        it "should return a 404 error message if the bit is not found" do
            user = FactoryBot.create(:user)
            sign_in user
            get :edit, params: { id: 'SWAG' }
            expect(response).to have_http_status(:not_found)
        end
    end

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

            post :create, params: {
                bit: { 
                    message: 'Hello!',
                    pics: fixture_file_upload("/sample.jpg", 'image/jpg')
                    } 
                }
                
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
