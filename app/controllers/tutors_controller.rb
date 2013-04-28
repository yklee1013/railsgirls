class TutorsController < ApplicationController
  before_filter :admin_required

  def index
    @tutors = Event.find(params[:event_id]).tutors
  end

  def create
    t = Tutor.new params[:tutor]
    t.event = Event.find(params[:event_id])
    t.attended = true
    t.save

    redirect_to event_tutors_path(params[:event_id])
  end
end
