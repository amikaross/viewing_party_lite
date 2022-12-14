# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def error_message(errors)
    errors.details.keys.map do |field|
      errors.full_messages_for(field).first
    end.join(", ") 
  end
end
