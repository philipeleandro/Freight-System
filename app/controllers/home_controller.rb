# Root path

class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.kind == 'Regular'
        render 'index'
      else
        redirect_to companies_path
      end
    end
  end
end
