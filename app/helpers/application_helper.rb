module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def simple_date(date)
    date.strftime("%m/%d/%Y at %H:%M")
  end

  def default_or_session_background
    if session[:background_id]
      session[:background_id]
    else
      # kludgy hack to make sure we pick the wooden background
      if Background.global.where(:id => 28).empty?
        Background.global.first.id
      else
        28
      end
    end
  end
end
