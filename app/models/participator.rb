class Participator < ActiveRecord::Base
  attr_accessible :attended, :email, :name, :type

  belongs_to :event

  scope :has_attended, where(:attended => true)
end
