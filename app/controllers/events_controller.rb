class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_event, only: [:show]
  before_action :set_current_user_event, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  # GET /events/new
  def new
    @event = current_user.events.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)
    setCoordinatesByAddress if @event.address.present?
  
    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new 
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    setCoordinatesByAddress if @event.address.present?

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def setCoordinatesByAddress
    client = OpenStreetMap::Client.new
    result = client.search(q: @event.address, format: 'json', addressdetails: '1', accept_language: 'ru')
    client = nil
    @event.lat = result[0]["lat"]&.to_d
    @event.lon = result[0]["lon"]&.to_d
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :description, :datetime)
  end
  
end
