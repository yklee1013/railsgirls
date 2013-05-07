class HomeController < ApplicationController
  def index
    @events = Event.upcoming
  end

  def about
  end
end
