class User < ActiveRecord::Base
  attr_accessible :access_token, :email, :name
  has_many :registrations, :dependent => :destroy
  has_many :events, :through => :registrations

  before_save { |user| user.email = email.downcase }

  validates :name, :presence => true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }
  validates :access_token, :presence => true, :uniqueness => true

  def register(event_id)
    registrations.create!(event_id: event_id)
  end

  def registered?(event_id)
    !registrations.find_by_event_id(event_id).nil?
  end
end
