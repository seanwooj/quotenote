class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :initialize_cart

  def authenticate_admin!
    authenticate_user!

    unless current_user.admin?
      redirect_to root_path, :alert => "You aren't allowed to be here!"
    end
  end

  def initialize_cart
    @cart = Cart.create_from_hash session
  end
end
