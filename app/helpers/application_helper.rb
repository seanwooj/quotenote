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
end
