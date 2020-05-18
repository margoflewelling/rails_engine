Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#find'
        get ':id/items', to: 'items#index'
      end
      resources :merchants, except: [:new, :edit]

     namespace :items do
       get 'find', to: 'search#find'
       get ':id/merchant', to: 'merchants#show'
     end
     resources :items, except: [:new, :edit]

    end
  end

end
