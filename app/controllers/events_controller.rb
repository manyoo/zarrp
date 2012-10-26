class EventsController < ApplicationController
  include EventsControllerHelper

  def index
    if authenticated?
      eventcities = Event.select(:city).uniq
      @cities = eventcities.map { |event| event.city }
      @events = Event.where("time > :now", :now => Time.now).order(:time)
      cur_city = params[:city]
      if cur_city
        @events = @events.where("city=?", cur_city)
      end
      @events = @events.paginate(page:params[:page], per_page:5)
      @events_by_date = @events.group_by { |event| event.time.to_date }
      @dates = @events_by_date.keys
      respond_to do |format|
        format.html
        format.js
      end
    else
      render 'error'
    end
  end

  def show
    if authenticated?
      @event = Event.find(params[:id])
    else
      render 'error'
    end
  end

  def register
    @current_user = User.find_by_access_token(params[:user_access_token])
    if @current_user
      @event = Event.find(params[:id])
      begin
        @current_user.register(@event.id)
        if !sendTicket(@current_user, @event)
          @current_user.unregister(@event.id)
          render :js => "alert('Failed to add ticket')"
        else
          respond_to do |format|
            format.js
          end
        end
      rescue
        render :js => "alert('Already registered')"
      end
    else
      render :js => "alert('Invalid User')"
    end
  end

  private
  def authenticated?
    @access_token = params[:user_access_token]
    authenticate_user
  end
end
