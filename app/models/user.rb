class User < ActiveRecord::Base
  attr_accessible :access_token, :email, :name
  has_many :registrations, :dependent => :destroy
  has_many :events, :through => :registrations

  before_save { |user| user.email = email.downcase }

  validates :name, :presence => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }
  validates :access_token, :presence => true, :uniqueness => true
end
