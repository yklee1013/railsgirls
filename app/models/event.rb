class Event < ActiveRecord::Base
  attr_accessible :body, :city, :map, :starts_at, :summary, :title

  has_many :participators
end
