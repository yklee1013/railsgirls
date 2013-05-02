class Event < ActiveRecord::Base
  has_many :participators, :dependent => :destroy

  scope :upcoming, where("starts_at > #{Date.today}")

  def tutors
    participators.where(:type => 'Tutor')
  end

  def girls
    participators.where(:type => 'Girl')
  end

  def pair
    members = participators.has_attended

    tutors = members.where(:type => 'Tutor').shuffle
    girls = members.where(:type => 'Girl').shuffle
    return {} if  tutors.size * girls.size == 0

    t_g_ratio = (girls.size / tutors.size).to_i
    # puts "girls: #{girls.size} tutors: #{tutors.size} t_g_ratio: #{t_g_ratio}"

    result = {}

    tutors.each do |tutor|
      result.merge! tutor.name => girls.slice!(0, t_g_ratio).map(&:name)
    end

    girls.each_with_index do |girl, i|
      result.values[i]<< girl.name
    end

    result.each_value do |r|
      (3 - r.size).times { r<< '' } if r.size < 3
    end

    result
  end
end
