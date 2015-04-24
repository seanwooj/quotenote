class Generator
  def self.generate(params = {})
    params[:font_color] = 'black' if !params[:font_color]
    options = params
  end

  def self.generate_image(quote_note)
    options = quote_note.serialize_relevant_with_indifferent_access
    options[:quote_text] = options[:quote_text].split("\n")
    template = ImageGeneratorService.new()
    template.options = options
    template.background_url = quote_note.background.image.url

    string = template.render_to_string 'generator/generate.html.haml'

    kit = IMGKit.new(template.render_to_string('generator/generate.html.haml'))
    kit.javascripts << "#{Rails.root}/public/imgkit_application.js"

    # string
    kit.to_jpg
  end

  def self.generate_image_file(quote_note)
    img = self.generate_image(quote_note)
    file = Tempfile.new(["quote_image", ".jpg"], 'tmp', :encoding => 'ascii-8bit')
    file.write(img)
    file
  end

  def self.generate_and_save(quote_note)
    file = self.generate_image_file(quote_note)
    quote_note.image = file
    file.unlink
    quote_note.save!
  end
end
