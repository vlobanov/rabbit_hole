module RabbitHole::Remember
  private
  def storage_type
    if @storage_type.nil?
      if RabbitHole::remember_for.nil? || RabbitHole::remember_for <= 0
        @storage_type = :session
      else
        @storage_type = :cookies
      end
    end
    @storage_type
  end

  def sign_in!
    if storage_type == :session
      session[:user] = 'admin'
    elsif storage_type == :cookies
      cookies.signed[:user] = { :value => 'admin', :expires => RabbitHole::remember_for.from_now }
    end
  end

  def signed_in?
    if storage_type == :session
      session[:user] == 'admin'
    elsif storage_type == :cookies
      cookies.signed[:user] == 'admin'
    end
  end

  def sign_out!
    if storage_type == :session
      session[:user] = nil
    elsif @storage_type == :cookies
      cookies.delete :user
    end
  end
end