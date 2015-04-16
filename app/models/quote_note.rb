class QuoteNote < ActiveRecord::Base
  belongs_to :background

  def arrayified_quote_text
    quote_text == '' ? [''] : quote_text.split("\n")
  end

  def serialize_for_client
    hash = self.serializable_hash

    hash["quote_text"] = arrayified_quote_text

    # if for whatever reason background isn't set, set some defaults.
    # this should be removed later on.
    hash["repeating"] = (background.nil? ? false : background.repeating)
    hash["background_id"] = (background.nil? ? 3 : background.id)
    hash
  end

  def serialize_for_client_json
    serialize_for_client.to_json
  end

  def full_size_image_url
    # should probably remove the extraneous attributes on the model
    # but for now it is not harmful.
    hash = serialize_for_client
    hash["full_size"] = true
    "/generator.jpg?" + hash.to_query
  end
end
