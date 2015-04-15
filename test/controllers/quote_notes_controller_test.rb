require "test_helper"

class QuoteNotesControllerTest < ActionController::TestCase

  def quote_note
    @quote_note ||= quote_notes :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:quote_notes)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('QuoteNote.count') do
      post :create, quote_note: { background_id: quote_note.background_id, font_color: quote_note.font_color, font_family: quote_note.font_family, overlay: quote_note.overlay, quote_author: quote_note.quote_author, quote_text: quote_note.quote_text }
    end

    assert_redirected_to quote_note_path(assigns(:quote_note))
  end

  def test_show
    get :show, id: quote_note
    assert_response :success
  end

  def test_edit
    get :edit, id: quote_note
    assert_response :success
  end

  def test_update
    put :update, id: quote_note, quote_note: { background_id: quote_note.background_id, font_color: quote_note.font_color, font_family: quote_note.font_family, overlay: quote_note.overlay, quote_author: quote_note.quote_author, quote_text: quote_note.quote_text }
    assert_redirected_to quote_note_path(assigns(:quote_note))
  end

  def test_destroy
    assert_difference('QuoteNote.count', -1) do
      delete :destroy, id: quote_note
    end

    assert_redirected_to quote_notes_path
  end
end
