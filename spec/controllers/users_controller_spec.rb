require 'spec_helper'

describe UsersController do

  describe "GET 'register'" do
    it "returns http success" do
      get 'register'
      response.should be_success
    end
  end

end
