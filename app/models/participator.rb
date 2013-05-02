class Participator < ActiveRecord::Base
  validates :name, :presence => true

  belongs_to :event

  scope :has_attended, where(:attended => true)
  scope :girls, where(:type => 'Girl')
  scope :tutors, where(:type => 'Tutor')

  def attend
    self.attended = true
    save
  end
end
