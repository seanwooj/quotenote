class BackgroundsController < ApplicationController
  before_action :set_background, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, :only => [:show, :new, :edit, :create, :index, :update, :destroy]

  # GET /backgrounds
  # GET /backgrounds.json
  def index
    @backgrounds = Background.all
  end

  # GET /backgrounds/1
  # GET /backgrounds/1.json
  def show
  end

  # GET /backgrounds/new
  def new
    @background = Background.new
  end

  # GET /backgrounds/1/edit
  def edit
  end

  # POST /backgrounds
  # POST /backgrounds.json
  def create
    @background = Background.new(background_params)

    if current_user
      @background.user = current_user

      if current_user.admin?
        @background.global = true
      end
    else
      @background.session_id = session[:session_id]
    end

    respond_to do |format|
      if @background.save
        format.html { redirect_to @background, notice: 'Background was successfully created.' }
        format.json { render :show, status: :created, location: @background }
      else
        format.html { render :new }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backgrounds/1
  # PATCH/PUT /backgrounds/1.json
  def update
    respond_to do |format|
      if @background.update(background_params)
        format.html { redirect_to @background, notice: 'Background was successfully updated.' }
        format.json { render :show, status: :ok, location: @background }
      else
        format.html { render :edit }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backgrounds/1
  # DELETE /backgrounds/1.json
  def destroy
    @background.destroy
    respond_to do |format|
      format.html { redirect_to backgrounds_url, notice: 'Background was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_and_redirect_to_quotenote
    @background = Background.new(background_params)
    @background.name = Background.generate_unique_name

    if current_user
      @background.user = current_user

      if current_user.admin?
        @background.global = true
      end
    else
      @background.session_id = session[:session_id]
    end

    respond_to do |format|
      if @background.save
        session[:background_id] = @background.id
        format.html { redirect_to :back, notice: 'Background was successfully created.' }
        format.json { render :show, status: :created, location: @background }
      else
        format.html { render :new }
        format.json { render json: @background.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_background
      @background = Background.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def background_params
      params.require(:background).permit(:image, :name)
    end
end
