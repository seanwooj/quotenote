class Generator
  def self.generate(params = {})
    params[:font_color] = 'black' if !params[:font_color]
    options = params
  end
end
