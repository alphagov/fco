Fco::Application.routes.draw do

  scope "travel-advice" do
    root :to => 'home#show'
    match '/countries/:id', :to => 'countries#show', :as => :country, :via => :get
    match '/countries/:country_id/missions/:id', :to => 'missions#show', :as => :mission, :via => :get
    match '/news/:year/:month/:day/:slug',
      :constraints => {
        :year => /[0-9]{4}/, :month => /[0-9]{2}/, :day => /[0-9]{2}/
      },
      :as => :news_item,
      :to => 'travel_news#show',
      :via => :get
  end

end