class GeneratorController < ApplicationController
  # layout false

  def generate
    @options = Generator.generate(params)
    @kit = IMGKit.new(render_to_string(:action => 'generate.html.haml'))

    @kit.javascripts << "#{Rails.root}/public/imgkit_application.js"

    @string = render_to_string(:action => 'generate.html.haml', :layout => 'application.html.haml')
    respond_to do |format|
      format.jpg do
        send_data(@kit.to_jpg, :type => "image/jpeg", :disposition => 'inline')
      end
      format.html
    end
  end

end
