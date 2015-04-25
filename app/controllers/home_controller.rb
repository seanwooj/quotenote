class HomeController < ApplicationController
  layout 'home_page_layout'
  def index
    @backgrounds = Background.all
  end
end
