require_relative 'remember'

module RabbitHole::Protection
  include RabbitHole::Remember

  def check_auth!
    redirect_to RabbitHole::redirect_to_if_denied unless signed_in?
  end

  def self.included(cl)
    cl.send(:before_filter, :check_auth!)
  end
end