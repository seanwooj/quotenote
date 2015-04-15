json.array!(@quote_notes) do |quote_note|
  json.extract! quote_note, :id, :quote_text, :font_family, :quote_author, :background_id, :overlay, :font_color
  json.url quote_note_url(quote_note, format: :json)
end
