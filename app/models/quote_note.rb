class QuoteNote < ActiveRecord::Base
  belongs_to :background

  def serialize_for_client
    hash = self.serializable_hash
    hash["quote_text"] = hash["quote_text"].split("\n")
    hash["repeating"] = background.repeating
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
