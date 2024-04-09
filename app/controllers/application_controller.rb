# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  # rescue_from Exception, with: :render500
  rescue_from ActiveRecord::RecordNotFound, with: :render404
  rescue_from ActionController::RoutingError, with: :render404

  before_action :basic_auth unless Rails.env.test?
  before_action :require_login

  protect_from_forgery with: :null_session

  add_flash_types :success, :info, :warning, :danger

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def require_login
    redirect_to login_path, danger: 'ログインしてください' unless logged_in?
  end

  def render401
    render 'error/401', status: :unauthorized, layout: nil
  end

  def render404
    render 'error/404', status: :not_found, layout: nil
  end

  def render422
    render 'error/422', status: :unprocessable_entity, layout: nil
  end

  def render500
    render 'error/500', status: :internal_server_error, layout: nil
  end
end
