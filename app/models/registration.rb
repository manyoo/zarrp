class Registration < ActiveRecord::Base
  attr_accessible :event_id
  belongs_to :register, :class_name => "User", :foreign_key => "user_id"
  belongs_to :event

  validates :event_id, :presence => true
  validates :user_id, :presence => true
  validates :user_id, :uniqueness => { :scope => :event_id }
end
