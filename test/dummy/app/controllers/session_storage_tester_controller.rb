class SessionStorageTesterController < ApplicationController
  include RabbitHole::Remember

  def remember
    sign_in!
    set_view_vars
    render :inline => ''# :index
  end

  def forget
    sign_out!
    set_view_vars
    render :inline => ''# :index
  end

  def index
    set_view_vars
    render :index
  end

  def set_view_vars
    @session_val = session[:user]
    @cookies_val = cookies.signed[:user]
    @remembered = signed_in? ? 'true' : 'false'
  end
end
