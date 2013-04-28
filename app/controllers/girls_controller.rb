class GirlsController < ApplicationController
  before_filter :admin_required

  def index
    @girls = Event.find(params[:event_id]).girls
  end

  def create
    g = Girl.new params[:girl]
    g.event = Event.find(params[:event_id])
    g.attended = true
    g.save

    redirect_to event_girls_path(params[:event_id])
  end

  def attend
    g = Event.find(params[:event_id]).participators.find(params[:id])
    g.attended = true
    g.save

    redirect_to event_girls_path(params[:event_id])
  end
end
