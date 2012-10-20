class EventsController < ApplicationController
  def index
    @events_today = Event.all
    @events_tomorrow = []
  end

  def show
    @event = Event.find(params[:id])
  end
end
