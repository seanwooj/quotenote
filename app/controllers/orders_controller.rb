class OrdersController < ApplicationController
  def show
    @order = Order.includes(:order_items => [:quote_note]).includes(:user).find(params[:id])
  end

  def index
    @orders = Order.includes(:order_items => [:quote_note, :product]).includes(:user).all
  end

  def create
    if order_params[:user][:id]
      user = User.find(order_params[:user][:id])
    else
      user = User.new(order_params[:user])
    end

    @order_form = OrderForm.new(
      :user => user,
      :cart => @cart # pulled from the initialize cart before action in app controller
    )

    if @order_form.save
      #if charge user
      empty_cart
      sign_in(:user, user)
      redirect_to root_path, :notice => 'Thanks for your business!'
    else
      render 'carts/checkout'
    end
  end

  def pay

  end

  def order_params
    params.require(:order_form).permit(
      :user => [:name, :phone, :address, :city, :country, :postal_code, :email, :id, :password, :password_confirmation]
    )
  end

  private

  def empty_cart
    @cart.empty
    session['cart'] = @cart.serialize
  end
end
