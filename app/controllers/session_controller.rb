class SessionController < ApplicationController
  def login
    if signed_in?
      redirect_to RabbitHole.redirect_to_after_login
      return
    end
  end

  def begin_session
    if RabbitHole.password_correct?(params[:password])
      sign_in!
      redirect_to RabbitHole.redirect_to_after_login
      return
    end

    render 'login'
  end

private
  def signed_in?
    session[:user] == 'bro'
  end

  def sign_in!
    session[:user] = 'bro'
  end
end
