class User < ActiveRecord::Base
  attr_accessible :access_token, :email, :name
end
