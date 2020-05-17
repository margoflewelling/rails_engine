Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
namespace :api do
  namespace :v1 do

    namespace :merchants do
      get '', to: 'merchants#index'
      get ':id', to: 'search#show'
      post '', to: 'merchants#create'
      delete ':id', to: 'merchants#destroy'
      put ':id', to: 'merchants#update'
      patch ':id', to: 'merchants#update'
      get ':id/items', to: 'items#index'
   end

   namespace :items do
     get '', to: 'items#index'
     get ':id', to: 'search#show'
     post '', to: 'items#create'
     delete ':id', to: 'items#destroy'
     put ':id', to: 'items#update'
     patch ':id', to: 'items#update'
     get ':id/merchant', to: 'merchants#show'

   end

  end
end

end
