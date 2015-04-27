class OrdersController < ApplicationController
  before_action :authenticate_admin!, :only => [:index, :show]


  def show
    @order = Order.includes(:order_items => [:quote_note]).includes(:user, :order_status_transitions).find(params[:id])
  end

  def index
    @orders = Order.includes(:order_items => [:quote_note, :product]).includes(:user).all
  end

  def create
    if order_params[:user][:id]
      user = User.find(order_params[:user][:id])
      user.assign_attributes(order_params[:user])
    else
      user = User.new(order_params[:user])
    end

    @order_form = OrderForm.new(
      :user => user,
      :cart => @cart # pulled from the initialize cart before action in app controller
    )

    if @order_form.save
      sign_in(:user, user)
      if charge_user
        empty_cart
        print_io_order_post
        redirect_to confirmation_order_path(@order_form.order)
      else
        # redirect to the pay route
      end

    else
      render 'carts/checkout'
    end
  end

  def pay

  end

  def retry_print_api_call
    @order = Order.find(params[:order_id])
    @order.post_api_order
    redirect_to :back
  end

  def confirmation
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order_form).permit(
      :user => [:name, :phone, :address, :city, :country, :postal_code, :email, :id, :password, :password_confirmation]
    )
  end

  def empty_cart
    @cart.empty
    session['cart'] = @cart.serialize
  end

  def charge_user
    transaction = OrderTransaction.new @order_form.order, params[:payment_method_nonce]
    transaction.execute
    transaction.ok?
  end

  def print_io_order_post
    @order_form.order.post_api_order
  end
end
