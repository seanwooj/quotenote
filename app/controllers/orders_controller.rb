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
        unless print_io_order_post
          # raise some error and email support
          # also do something with the status
        end
        redirect_to root_path, :notice => 'Thanks for placing your order!'
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
    ps = PrintIOService.new(@order_form.order)
    ps.post_order
    ps.ok?
  end
end
