# encoding: utf-8
class GirlsController < ApplicationController
  before_filter :admin_required

  def index
    @girls = current_event.girls
  end

  def create
    g = current_event.girls.build params[:girl] do |girl|
     girl.attended = true
    end

    if g.save
      flash[:notice] = t('event.attend.success', :name => g.name)
    else
      flash[:notice] = t('event.attend.fail', :name => g.name)
    end

    redirect_to event_girls_path(params[:event_id])
  end

  def attend
    g = Event.find(params[:event_id]).participators.find(params[:id])
    if g.attend
      flash[:notice] = t('event.attend.success', :name => g.name)
    else
      flash[:notice] = t('event.attend.fail', :name => g.name)
    end

    redirect_to event_girls_path(params[:event_id])
  end

  def import
    require 'csv'
    # csv format: "微博昵称,粉丝数,微博数,真实姓名,联系地址,联系电话,电子邮箱"
    # csv origin encoding: GBK
    # csv separator: comma
    CSV.open(params[:csv].tempfile, encoding: 'GBK:UTF-8') do |csv|
      # first row is header, so skip it
      csv.drop(1).each do |row|
        current_event.girls.create :name => row[0], :email => row[6]
      end
    end
    redirect_to (event_girls_path(params[:event_id]))
  end

  private
  def current_event
    Event.find(params[:event_id])
  end
end
