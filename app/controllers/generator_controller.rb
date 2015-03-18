class GeneratorController < ApplicationController
  # layout false

  def generate
    @hide_feedback = true

    @options = Generator.generate(params)
    background_id = @options[:background_id]
    @background = Background.find(background_id)

    if @options[:full_size]
      @background_url = @background.image.url
    else
      @background_url = @background.image.url(:small)
    end

    @kit = IMGKit.new(render_to_string(:action => 'generate.html.haml'))

    @kit.javascripts << "#{Rails.root}/public/imgkit_application.js"

    @string = render_to_string(:action => 'generate.html.haml', :layout => 'application.html.haml')
    respond_to do |format|
      format.jpg do
        send_data(@kit.to_jpg, :type => "image/jpeg", :disposition => 'attachment')
      end
      format.html
    end
  end

end
