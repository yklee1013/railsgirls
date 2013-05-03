class Event < ActiveRecord::Base
  MAX_TUTOR_HANDLE_GIRLS = 3

  has_many :participators, :dependent => :destroy

  scope :upcoming, where('starts_at > ?', Date.today)

  def tutors
    participators.where(:type => 'Tutor')
  end

  def girls
    participators.where(:type => 'Girl')
  end

  def pair
    members = participators.attendee

    tutors = members.tutors.shuffle
    girls = members.girls.shuffle
    return {} if  tutors.size * girls.size == 0

    t_g_ratio = (girls.size / tutors.size).to_i

    result = {}

    tutors.each do |tutor|
      result.merge! tutor.name => girls.slice!(0, t_g_ratio).map(&:name)
    end

    girls.each_with_index do |girl, i|
      result.values[i]<< girl.name
    end

    result.each_value do |r|
      (MAX_TUTOR_HANDLE_GIRLS - r.size).times { r<< '' } if r.size < MAX_TUTOR_HANDLE_GIRLS
    end

    result
  end
end
