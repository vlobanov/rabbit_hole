require "rabbit_hole/engine"

module RabbitHole
  mattr_accessor :redirect_to_if_denied
  @@redirect_to_if_denied = :root_path

  mattr_accessor :redirect_to_after_login
  @@redirect_to_after_login = :root_path

  mattr_accessor :use_password_field
  @@redirect_to_after_login = true

  mattr_accessor :password
  @@password = 'abc'

  mattr_accessor :password_provider
  @@password_provider = nil

  mattr_accessor :routes_scope
  @@routes_scope = 'admin'

  def self.setup
    yield self
  end
end
