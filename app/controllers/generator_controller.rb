class GeneratorController < ApplicationController

  def generate
    @options = Generator.generate(params)
  end

end
