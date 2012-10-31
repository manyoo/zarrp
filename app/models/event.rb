class Event < ActiveRecord::Base
  attr_accessible :address, :club, :desc, :email, :city,
                  :name, :subname, :phone, :short_desc, :time, 
                  :price, :avatar, :image, :addon_code
  has_many :registrations, :dependent => :destroy
  has_many :registers, :through => :registrations, :class_name => "User"

  has_attached_file :avatar
  has_attached_file :image

  before_save { |event| event.email = email.downcase }

  validates :name, :presence => true
  validates :city, :presence => true
  validates :address, :presence => true
  validates :club, :presence => true
  validates :phone, :presence => true
  validates :short_desc, :presence => true, :length => { :maximum => 50 }
  validates :desc, :presence => true
  validates :time, :presence => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }

  validates_attachment_presence :avatar
  validates_attachment_presence :image
  validates :addon_code, :presence => true
end
