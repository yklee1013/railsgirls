class AdminController < ApplicationController
  before_filter :admin_required
  def index
    @events = Event.all
    @articles = Article.all
  end
end
