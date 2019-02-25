class RsvpsController < ApplicationController
  before_action :check_permissions, except: [:new, :create]
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]


  def index
    @active = params[:active] == "true" ? true : false
    if @active == true
      @rsvps = Rsvp.where("rsvp_date >= ?", Date.today).order(:rsvp_date, :rsvp_time)
    else
      @rsvps = Rsvp.all
    end
  end

  def new
    @rsvp = Rsvp.new
  end

  def create
    @rsvp = Rsvp.new(rsvp_params)
    byebug
    if helpers.free_spots(@rsvp.rsvp_date) >= @rsvp.pax
      respond_to do |format|
        if @rsvp.save
          format.html { redirect_to root_path}
        else
          format.html { render action: :new }
        end
      end
    else
      @rsvp.errors.add :name, "No quedan plazas disponibles para ese día. Lamentamos las molestias."
      render action: :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @rsvp.update(rsvp_params)
        flash[:notice] =  'La reserva se ha actualizado.'
        format.html { redirect_to action: :index }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @rsvp.destroy
    respond_to do |format|
      flash[:notice] =  'La reserva se ha eliminado.'
      format.html { redirect_to action: :index }
    end
  end

private
  def set_rsvp
    @rsvp = Rsvp.find(params[:id])
  end

  def check_permissions
    unless user_signed_in?
      redirect_to root_path
    end

  end

  def rsvp_params
    params.require(:rsvp).permit(:name, :rsvp_date, :pax, :telephone, :rsvp_time, "g-recaptcha-response")
  end
end
