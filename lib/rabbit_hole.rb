require "rabbit_hole/engine"

module RabbitHole
  OPTION_NAMES = [
    :redirect_to_if_denied,
    :redirect_to_after_login,
    :use_password_field,
    :password,
    :password_provider,
    :routes_scope,
    :auth_failed_message]

  def self.set_defaults
    @@redirect_to_if_denied = '/'
    @@redirect_to_after_login = '/'
    @@use_password_field = true
    @@password = 'aaaaaa'
    @@password_provider = nil
    @@routes_scope = 'admin'
    @@auth_failed_message = "sorry, the password you entered is wrong"
  end

  mattr_accessor *OPTION_NAMES
  set_defaults

  def self.setup
    yield self
  end

  def self.get_password
    @@password
  end

  def self.password_correct?(given_password)
    self.get_password == given_password
  end

  module Protection
    def check_auth!
      redirect_to RabbitHole::redirect_to_if_denied unless session[:user] == 'bro'
    end

    def self.included(cl)
      cl.send(:before_filter, :check_auth!)
    end

    def signed_in?
      session[:user] == 'bro'
    end

    def sign_in!
      session[:user] = 'bro'
    end
  end
end
