Fco::Application.routes.draw do

  root :to => 'home#show'
  match '/countries/:id', :to => 'countries#show', :as => :country, :via => :get
  match '/news/:year/:month/:day/:slug',
    :constraints => {
      :year => /[0-9]{4}/, :month => /[0-9]{2}/, :day => /[0-9]{2}/
    },
    :as => :news_item,
    :to => 'travel_news#show',
    :via => :get

end