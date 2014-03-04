require 'spec_helper'

describe SessionsController do 
  describe "GET 'new'" do
    it "is successful" do
      get :new
      expect(response).to be_successful
    end

    it "should not render if user id signed in" do
      user = double("User", id: 1, remember_token: "abc") 

      User.stub(:find).with(1) {user}
      cookies[:user_id] = user.id
      cookies[:remember_token] = "abc"
      get :new
      expect(response).to redirect_to root_path
    end
  end


end