# This solution via
# https://gist.github.com/juggy/977181
class ImageGeneratorService < AbstractController::Base
  include AbstractController::Logger
  include AbstractController::Rendering
  include ActionView::Layouts
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
  Rails.application.routes.default_url_options = { :host => 'www.yoursite.com' }

  helper ApplicationHelper

  helper_method :protect_against_forgery?

  attr_accessor :quote_note, :options, :background_url

  # configure the different paths correctly
  def initialize(*args)
    super()
    lookup_context.view_paths = Rails.root.join('app', 'views')
    config.javascripts_dir = Rails.root.join('public', 'javascripts')
    config.stylesheets_dir = Rails.root.join('public', 'stylesheets')
    config.assets_dir = Rails.root.join('public')
  end

  # we are not in a browser, no need for this
  def protect_against_forgery?
    false
  end

  # so that your flash calls still work
  def flash
    {}
  end

  def params
    {}
  end

  # same asset host as the controllers
  self.asset_host = ActionController::Base.asset_host
end
