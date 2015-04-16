class QuoteNote < ActiveRecord::Base
  belongs_to :background

  def serialize_for_client
    hash = self.serializable_hash
    hash["quote_text"] = hash["quote_text"].split("\n")
    hash["repeating"] = background.repeating
    hash.to_json
  end
end
