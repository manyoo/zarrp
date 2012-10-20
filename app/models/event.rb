class Event < ActiveRecord::Base
  attr_accessible :address, :club, :desc, :email, :name, :phone, :short_desc, :time
end
