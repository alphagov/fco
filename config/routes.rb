Fco::Application.routes.draw do

  root :to => 'home#show'
  match '/countries/:id', :to => 'countries#show', :as => :country, :via => :get

end
