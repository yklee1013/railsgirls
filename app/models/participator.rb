class Participator < ActiveRecord::Base
  attr_accessible :attended, :email, :name, :type

  belongs_to :event

  scope :has_attended, where(:attended => true)
  scope :girls, where(:type => ::Girl)
  scope :tutors, where(:type => ::Tutor)
end
