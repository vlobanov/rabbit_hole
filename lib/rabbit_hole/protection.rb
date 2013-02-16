module RabbitHole::Protection
  def check_auth!
    redirect_to RabbitHole::redirect_to_if_denied unless signed_in?
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