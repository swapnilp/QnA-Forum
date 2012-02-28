class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_sign_in_path_for(resource_or_scope)
    question_index_path
  end
end
