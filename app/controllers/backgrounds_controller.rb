class BackgroundsController < ApplicationController
  def new
    @background = Background.new
  end

  def create
    @background = Background.create(background_params)
  end

  def index
    @backgrounds = Background.all
  end

  private

  def background_params
    params.require(:background).permit(:name, :source_url, :creator, :license_type, :image)
  end
end
