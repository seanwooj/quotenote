class Products::QuoteNotesController < ApplicationController
  before_action :set_product
  before_action :set_quote_note

  def show

  end

  private

  def set_quote_note
    @quote_note = QuoteNote.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
