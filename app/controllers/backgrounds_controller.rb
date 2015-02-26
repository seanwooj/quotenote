class BackgroundsController < ApplicationController
  def new
    @background = Background.new
  end

  def create
    @background = Background.new(background_params)
    if @background.save!
      redirect_to :action => 'index'
    end
  end

  def index
    @backgrounds = Background.all
  end

  private

  def background_params
    params.require(:background).permit(:name, :source_url, :creator, :license_type, :image)
  end
end
