class WebController < ApplicationController
  before_action :check_permissions, except: [:new, :create]

  def index
    @rsvp = Rsvp.new
  end


private


  def check_permissions
    unless user_signed_in?
      redirect_to root_path
    end

  end
end
