Rails.application.routes.draw do
  scope RabbitHole.routes_scope do
    match "/login" => "session#login", :via => :get, :as => :login
    match "/login" => "session#begin_session", :via => :post, :as => :begin_session
    match "/logout" => "session#logout", :as => :logout
  end
end
