class OrdersController < ApplicationController
  before_action :authenticate_admin!, :only => [:index, :show, :retry_print_api_call]


  def show
    @order = Order.includes(:order_items => [:quote_note]).includes(:user, :order_status_transitions).find(params[:id])
  end

  def index
    @orders = Order.includes(:order_items => [:quote_note, :product]).includes(:user).all
  end

  def create
    user = get_or_make_user_via_params(order_params)

    @order_form = OrderForm.new(
      :user => user,
      :cart => @cart # pulled from the initialize cart before action in app controller
    )

    # WE MUST CHECK TO ENSURE THAT A PAYMENT METHOD NONCE HAS BEEN PASSED IN.
    # braintree intercepts the form submission -- but not fast enough. the form submission happens
    # and gets cancelled quickly, but not quickly enough to prevent the first order form from
    # being saved, which saves the user. then braintree submits the form again, this time with
    # a payment nonce. that makes it through, but at that point the user is saved already, which
    # breaks the form flow.
    unless params[:payment_method_nonce] == ''

      if @order_form.save
        sign_in(:user, user)
        if charge_user
          empty_cart
          print_io_order_post
          CheckoutMailer.order_confirmation_email(user, @order_form.order).deliver_now
          redirect_to confirmation_order_path(@order_form.order)
        else
          raise PaymentError.new(order_params), "something went wrong with the payment #{order_params.to_s}"
        end
      else
        begin
          raise PaymentError.new(order_params), "something went wrong with the account information #{order_params.to_s}"
        rescue
          @client_token = Braintree::ClientToken.generate()
          render 'carts/checkout'
        end
      end

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

  def get_or_make_user_via_params order_params
    if order_params[:user][:id]
      user = User.find(order_params[:user][:id])
      user.assign_attributes(order_params[:user])
    else
      user = User.new(order_params[:user])
    end
    user
  end

  def order_params
    params.require(:order_form).permit(
      :user => [:first_name, :last_name, :phone, :address, :city, :country, :postal_code, :email, :id, :password, :password_confirmation, :state]
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
