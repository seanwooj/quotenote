ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => 'quotenote.it',
  :port => 587,
  :address => 'smtp.sendgrid.net',
  :authentication => :plain,
  :enable_startssl_auto => true
}
