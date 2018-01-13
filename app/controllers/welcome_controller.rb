class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if current_user
      redirect_to wikis_path
    end
  end

  def about
  end
end
