class SessionStorageTesterController < ApplicationController
  include RabbitHole::Remember

  def remember
    remember!
    set_view_vars
    render :inline => ''# :index
  end

  def forget
    forget!
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
    @remembered = remembered? ? 'true' : 'false'
  end
end
