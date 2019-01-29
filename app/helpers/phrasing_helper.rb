module PhrasingHelper
  def can_edit_phrases?
   user_signed_in? #only editors can sign in, so anyone signed in is a verified editor.
  end
end