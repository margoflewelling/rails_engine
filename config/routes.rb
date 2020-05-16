Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
namespace :api do
  namespace :v1 do
    namespace :merchants do
      get '', to: 'merchants#index'
      get ':id', to: 'search#show'
      post '', to: 'merchants#create'
      delete ':id', to: 'merchants#destroy'
   end
  end
end

end
