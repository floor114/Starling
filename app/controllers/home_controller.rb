class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to feeds_path(current_user)
    end
  end
end
