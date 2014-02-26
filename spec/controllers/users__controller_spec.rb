require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "is successful" do
      get :index
      response.should be_successful
    end
  end

  # describe "GET 'index'" do
  #   render_views
  #   it "has title 'Welcome to Congo!'" do
  #     get :index
  #     expect(response.body).to include("Welcome to Congo!") 
  #   end
  # end
end
