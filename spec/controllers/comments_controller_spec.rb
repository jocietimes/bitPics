require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    describe "comments#create action" do
        it "should allow users to create comments on bits" do
            bit = FactoryBot.create(:bit)
            user = FactoryBot.create(:user)
            sign_in user

            post :create, params: { bit_id: bit.id, comment: {message: 'awesome little bity'} }
            expect(response).to redirect_to root_path
            expect(bit.comments.length).to eq 1
            expect(bit.comments.first.message).to eq "awesome little bity"
        end

        it "should require a user to be logged in to comment on a bit" do
            bit = FactoryBot.create(:bit)
            post :create, params: { bit_id: bit.id, comment: {message: 'awesome little bity'} }
            expect(response).to redirect_to new_user_session_path
        end

        it "should return http status code of not found if the bit isn't found" do
            user = FactoryBot.create(:user)
            sign_in user

            post :create, params: { bit_id: 'YOLOSWAG', comment: {message: 'awesome little bity'} }
            expect(response).to have_http_status :not_found
        end
    end  
end
