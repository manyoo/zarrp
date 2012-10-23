class User < ActiveRecord::Base
  attr_accessible :access_token, :firstname, :lastname, :gender, :default_currency, :date_of_birth
  has_many :registrations, :dependent => :destroy
  has_many :events, :through => :registrations

  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :access_token, :presence => true, :uniqueness => true

  def register(event_id)
    registrations.create!(event_id: event_id)
  end

  def registered?(event_id)
    !registrations.find_by_event_id(event_id).nil?
  end
end
