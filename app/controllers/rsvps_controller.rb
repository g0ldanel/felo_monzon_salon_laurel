class RsvpsController < ApplicationController
  before_action :check_permissions, except: [:new, :create]

  def index
    @rsvps = Rsvp.all
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to root_path}
      else
        format.html { render action: :new }
      end
    end
  end
private


  def check_permissions
    unless user_signed_in?
      redirect_to root_path
    end

  end

  def rsvp_params
    params.require(:rsvp).permit(:name, :rsvp_date, :pax, :telephone)
  end
end
