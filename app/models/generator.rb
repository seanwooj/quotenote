class Generator
  def self.generate(params = {})
    params[:font_color] = 'black' if !params[:font_color]
    options = params
  end

  def self.generate_image(quote_note, option_overrides = {})
    options = quote_note.serialize_relevant_with_indifferent_access
    options[:quote_text] = options[:quote_text].split("\n")
    options[:height] = '1200px';
    options[:width] = '1200px';
    options = options.merge(option_overrides)
    template = ImageGeneratorService.new()
    template.options = options
    template.background_url = quote_note.background.image.url

    string = template.render_to_string 'generator/generate.html.haml'

    kit = IMGKit.new(template.render_to_string('generator/generate.html.haml'))
    kit.javascripts << "#{Rails.root}/public/imgkit_application.js"
    kit.to_jpg
  end

  def self.generate_image_file(quote_note, option_overrides = {})
    img = self.generate_image(quote_note, option_overrides)
    file = Tempfile.new(["quote_image", ".jpg"], 'tmp', :encoding => 'ascii-8bit')
    file.write(img)
    file
  end

  # this will generate an image preview again. which is shitty.
  # try and solve.
  def self.generate_and_save(quote_note, option_overrides = {})
    file = self.generate_image_file(quote_note, option_overrides)
    quote_note.image = file
    file.unlink
    quote_note.save!
  end

end
