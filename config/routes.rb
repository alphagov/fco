Fco::Application.routes.draw do

  match '/countries/:id', :to => 'countries#show'

end
