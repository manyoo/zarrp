class Event < ActiveRecord::Base
  attr_accessible :address, :club, :desc, :email, :name, :phone, :short_desc, :time
  has_many :registrations, :dependent => :destroy
  has_many :registers, :through => :registrations, :class_name => "User"

  before_save { |event| event.email = email.downcase }

  validates :name, :presence => true
  validates :address, :presence => true
  validates :club, :presence => true
  validates :phone, :presence => true
  validates :short_desc, :presence => true, :length => { :maximum => 50 }
  validates :desc, :presence => true
  validates :time, :presence => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }
end
