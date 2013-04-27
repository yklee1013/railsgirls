class Participator < ActiveRecord::Base
  attr_accessible :attended, :email, :name

  belongs_to :event
end
