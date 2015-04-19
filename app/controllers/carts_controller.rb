class CartsController < ApplicationController
  def show
  end

  def add
    @cart.add_item params[:product_id], params[:quote_note_id]
    session['cart'] = @cart.serialize
    redirect_to cart_path, :notice => 'thanks.'
  end

  def checkout
    @user = current_user || User.new
    @order_form = OrderForm.new(:user => @user, :cart => @cart)
    @client_token = Braintree::ClientToken.generate()
  end
end
