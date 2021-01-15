module AuthenticationSpecSupport
  def log_in(username)
    post join_path, params: { user: { name: username } }
    User.find(session[:current_user_id])
  end
end
