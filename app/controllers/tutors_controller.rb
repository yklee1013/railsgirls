class TutorsController < ApplicationController
  before_filter :admin_required

  def index
    @tutors = current_event.tutors
  end

  def create
    t = current_event.tutors.build params[:tutor] do |tutor|
      tutor.attended = true
    end

    if t.save
      flash[:notice] = t('event.attend.success', :name => t.name)
    else
      flash[:notice] = t('event.attend.fail', :name => t.name)
    end

    redirect_to event_tutors_path(params[:event_id])
  end

  private
  def current_event
    Event.find(params[:event_id])
  end
end
