class Participator < ActiveRecord::Base
  validates :name, :presence => true
  validates_uniqueness_of :event_id, :scope => [:name, :email]

  belongs_to :event

  scope :attendee, where(:attended => true)
  scope :girls, where(:type => 'Girl')
  scope :tutors, where(:type => 'Tutor')

  def attend
    self.attended = true
    save
  end
end
