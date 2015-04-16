class CartsController < ApplicationController
  def show
  end

  def add
    @cart.add_item params[:product_id], params[:quote_note_id]
    session['cart'] = @cart.serialize
    redirect_to :back, :notice => 'thanks.'
  end

  def checkout
    @order_form = OrderForm.new
    @client_token = Braintree::ClientToken.generate()
  end
end
