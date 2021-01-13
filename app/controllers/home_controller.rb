class HomeController < ApplicationController
  def index
    redirect_to join_path
  end
end
