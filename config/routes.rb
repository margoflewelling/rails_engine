Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      get 'revenue', to: 'revenue#dates'

      namespace :merchants do

        get 'find_all', to: 'search#find_all'
        get 'find', to: 'search#find'

        get 'most_items', to: 'stats#merchants_most_items'
        get 'most_revenue', to: 'stats#merchants_most_revenue'
        get ':id/revenue', to: 'stats#revenue'

        get ':id/items', to: 'items#index'
      end
      resources :merchants, except: [:new, :edit]

     namespace :items do
       
       get 'find_all', to: 'search#find_all'
       get 'find', to: 'search#find'

       get ':id/merchant', to: 'merchants#show'
     end
     resources :items, except: [:new, :edit]

    end
  end

end
