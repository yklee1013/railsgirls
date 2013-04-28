class EventsController < ApplicationController
  before_filter :find_event, :only => [:pair]
  before_filter :admin_required, :except => [:index, :show, :pair]
  before_filter :store_location, :only => [:tutors_attend, :girls_attend]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def pair
    @result = {}
    30.times do
      @result[Faker::Name.name] = [Faker::Name.name, Faker::Name.name, Faker::Name.name]
    end
  end

  def tutors_attend
    @tutors = Event.find(params[:id]).participators.where :type => Tutor
  end

  def girls_attend
    @girls = Event.find(params[:id]).participators.where :type => Girl
  end

  def attend
    p =  Event.find(params[:id]).participators.build(params[:participator])
    p.attended = true
    p.save!
    redirect_to (session[:return_to] || root_path)
  end

  def girl_attend
    g = Event.find(params[:id]).participators.find(params[:girl_id])
    g.attended = true
    g.save!
    redirect_to (session[:return_to] || root_path)
  end

  def participators
    participators = Event.find(params[:id]).participators.has_attended
    render json: {
        :girls => participators.select {|p| p.is_a? Girl }.collect {|g| g.name },
        :tutors => participators.select {|p| p.is_a? Tutor }.collect {|g| g.name }
    }
  end

  def import_csv
    require 'csv'
    CSV.foreach params[:csv].tempfile, encoding: 'GB2312:UTF-8' do |row|
      puts row
    end
    redirect_to (session[:return_to] || root_path)
  end

  private 
  def find_event
    @event = Event.find(params[:id])
  end
end
