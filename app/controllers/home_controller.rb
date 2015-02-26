class HomeController < ApplicationController
  def index
    @backgrounds = Background.all
  end
end
