class SessionController < ApplicationController
  include RabbitHole::Remember

  skip_before_filter :check_auth!, :only => [:login, :begin_session]

  def login
    if signed_in? and !Rails.env.test?
      redirect_to RabbitHole.redirect_to_after_login
      return
    end
  end

  def begin_session
    if RabbitHole::password_correct?(params[:password])
      sign_in!
      redirect_to RabbitHole.redirect_to_after_login
    else
      @error = RabbitHole.auth_failed_message
      render 'login'
    end
  end

  def logout
    sign_out!
    redirect_to RabbitHole::redirect_to_after_logout
  end
end
