class SessionController < ApplicationController
  def login
    #if signed_in? and !Rails.env.test?
    #  redirect_to RabbitHole.redirect_to_after_login
    #  return
    #end
  end

  def begin_session
    if RabbitHole::password_correct?(params[:password])
      sign_in!
      redirect_to RabbitHole.redirect_to_after_login
    else
      @error = RabbitHole::auth_failed_message
      render 'login'
    end
  end


end
