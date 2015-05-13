class CheckoutMailer < ApplicationMailer

  def order_confirmation_email user, order
    @user = user
    @order = order
    mail :to => @user.email, :subject => "Hey #{@user.first_name}! Thanks for your order!"
  end

end
