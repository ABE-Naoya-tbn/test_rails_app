# frozen_string_literal: true

module SessionsHelper
  def login(operator)
    session[:operator_email] = operator.email
  end

  def logout
    session.delete(:operator_email)
    @current_operator = nil
  end

  def current_operator
    return if session[:operator_email].blank?

    @current_operator ||= Operator.find_by(email: session[:operator_email])
  end

  def logged_in?
    !current_operator.nil?
  end
end
