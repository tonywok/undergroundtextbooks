require 'spec_helper'

describe UsersController do
  describe "When a user signs in" do
    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end
    it "makes sure they are signed in" do
      user = Factory.create(:user)
      sign_in user
      get(destroy_user_session_path)
      response.should be_success
    end
  end
end
