require "rabbit_hole/engine"
require "rabbit_hole/protection"
require "rabbit_hole/remember"

module RabbitHole
  OPTION_NAMES = [
    :redirect_to_if_denied,
    :redirect_to_after_login,
    :redirect_to_after_logout,
    :use_password_field,
    :password,
    :routes_scope,
    :auth_failed_message,
    :remember_for]

  def self.set_defaults
    @@redirect_to_if_denied = "/denied.html"
    @@redirect_to_after_login = '/?hello'
    @@redirect_to_after_logout = '/?bye'
    @@use_password_field = true
    @@password = nil
    @@password_provider = nil
    @@routes_scope = 'admin'
    @@auth_failed_message = "sorry, the password you entered is wrong"
    # nil or 0 means session
    # to set cookie
    # config.remember_for = 1.hour
    # or in seconds
    # config.remember_for = 60
    @@remember_for = nil
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
    fail "Password must be set" if self.get_password.nil?
    self.get_password == given_password
  end
end
