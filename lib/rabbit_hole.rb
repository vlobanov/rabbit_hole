require "rabbit_hole/engine"

module RabbitHole
  OPTION_NAMES = [
    :redirect_to_if_denied,
    :redirect_to_after_login,
    :use_password_field,
    :password,
    :password_provider,
    :routes_scope]

  def self.set_defaults
    @@redirect_to_if_denied = :root_path
    @@redirect_to_after_login = :root_path
    @@use_password_field = true
    @@password = nil
    @@password_provider = nil
    @@routes_scope = 'admin'
  end

  mattr_accessor *OPTION_NAMES
  set_defaults

  def self.setup
    yield self
  end

  def check_auth!
    redirect_to redirect_to_if_denied
  end

  mattr_accessor :included_into
  @@included_into = nil

  def RabbitHole.included(cl)
    @@included_into = cl
    cl.send(:before_filter, :check_auth!)
  end
end
