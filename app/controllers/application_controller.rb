class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :initialize_cart

  # Devise
  def authenticate_admin!
    authenticate_user!

    unless current_user.admin?
      redirect_to root_path, :alert => "You aren't allowed to be here!"
    end
  end

  # taken from the devise wiki
  # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referrer || root_path
    end
  end

  # Cart
  def initialize_cart
    @cart = Cart.create_from_hash session
  end

end
