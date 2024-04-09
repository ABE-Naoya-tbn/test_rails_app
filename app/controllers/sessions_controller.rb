# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  # GET : /login
  def new
    render :new, layout: nil
  end

  # POST : /login
  def create
    email = login_params[:email]
    password = login_params[:password]

    operator = Operator.find_by(email:)

    if operator&.authenticate(password)
      login operator
      redirect_to "/index", success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインできませんでした'
      render :new, layout: nil
    end
  end

  # DELETE : /logout
  def destroy
    logout
    redirect_to login_url, success: 'ログアウトしました'
  end

  private

  def login_params
    params.require(:session).permit(:email, :password, :username)
  end
end
