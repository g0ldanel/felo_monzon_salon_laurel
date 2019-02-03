class WebController < ApplicationController

  def index
  end


private


  def check_permissions
    unless user_signed_in?
      redirect_to root_path
    end

  end
end
