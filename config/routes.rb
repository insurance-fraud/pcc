Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :payments, only: [] do
    collection do
      post :pay
    end
  end
end
