class EventsController < ApplicationController
  def index
    @events_today = Event.all
    @events_tomorrow = []
  end

  def show
    @current_user = User.first # just for testing
    @event = Event.find(params[:id])
  end

  def register
    @user = User.first # this is just for test
    @user.register(params[:id])
    respond_to do |format|
        format.js
    end
  end
end
