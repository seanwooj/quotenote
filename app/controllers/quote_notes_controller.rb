class QuoteNotesController < ApplicationController
  before_action :set_quote_note, only: [:show, :edit, :update, :destroy]

  # GET /quote_notes
  # GET /quote_notes.json
  def index
    @quote_notes = QuoteNote.all
  end

  # GET /quote_notes/new
  def new
    @backgrounds = Background.all
    @quote_note = QuoteNote.new
  end

  # GET /quote_notes/1/edit
  def edit
    @quote_note = QuoteNote.find(params[:id])
    @backgrounds = Background.all
  end

  def show
    @products = Product.all
  end

  # POST /quote_notes
  # POST /quote_notes.json
  def create
    @quote_note = QuoteNote.new(quote_note_params)

    respond_to do |format|
      if @quote_note.save
        format.html { redirect_to @quote_note, notice: 'Quote note was successfully created.' }
        format.json { render :show, status: :created, location: @quote_note }
      else
        format.html { render :new }
        format.json { render json: @quote_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quote_notes/1
  # PATCH/PUT /quote_notes/1.json
  def update
    respond_to do |format|
      if @quote_note.update(quote_note_params)
        format.html { redirect_to @quote_note, notice: 'Quote note was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote_note }
      else
        format.html { render :edit }
        format.json { render json: @quote_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quote_notes/1
  # DELETE /quote_notes/1.json
  def destroy
    @quote_note.destroy
    respond_to do |format|
      format.html { redirect_to quote_notes_url, notice: 'Quote note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote_note
      @quote_note = QuoteNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_note_params
      params.require(:quote_note).permit(:quote_text, :font_family, :quote_author, :background_id, :overlay, :font_color)
    end
end
