require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :request do
  let!(:user) { create(:user) }
  let(:valid_params) { attributes_for(:user) }
  let(:invalid_params) { attributes_for(:user, password: "12345") }

  describe "GET devise/registrations#new" do
    it "renders a successful response" do
      get new_user_registration_path

      expect(response).to be_successful
    end
  end

  describe "GET devise/sessions#new" do
    it "renders a successful response" do
      get new_user_session_path

      expect(response).to be_successful
    end
  end

  describe "POST devise/registrations#create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect do
          post user_registration_path, params: { user: valid_params }
        end.to change(User, :count).by(1)

        expect(response).to be_redirect
        expect(flash[:notice]).to eq("Welcome! You have signed up successfully.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new user and renders a response with 422 status" do
        expect do
          post user_registration_path, params: { user: invalid_params }
        end.not_to change(User, :count)

        expect(response).to be_unprocessable
      end
    end
  end

  describe "POST devise/sessions#create" do
    context "with valid parameters" do
      it "creates a new session" do
        post user_session_path, params: { user: { email: user.email, password: user.password } }

        expect(response).to be_redirect
        expect(flash[:notice]).to eq("Signed in successfully.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new session and renders a flash alert message" do
        post user_session_path, params: { user: { email: user.email, password: "12345" } }

        expect(flash[:alert]).to eq("Invalid Email or password.")
      end
    end
  end

  describe "DELETE devise/sessions#destroy" do
    it "destroys user session" do
      delete destroy_user_session_path

      expect(response).to be_redirect
      expect(flash[:notice]).to eq("Signed out successfully.")
    end
  end
end
