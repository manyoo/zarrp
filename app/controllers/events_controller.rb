class EventsController < ApplicationController
  include EventsControllerHelper

  def index
    if authenticated?
      @events_today = Event.all
      @events_tomorrow = []
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
      begin
        @current_user.register(params[:id])
        respond_to do |format|
          format.js
        end
      rescue
        render :js => "alert('Already Registered')"
      end
    else
      render :js => "alert('Invalid User')"
    end
  end

  private
  def authenticated?
    @access_token = params[:user_access_token]
    @addon_token = params[:addOn_access_token]
    authenticate_user
  end
end
