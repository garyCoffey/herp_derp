Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  controller :site do
    post '/architecture', action: :architecture
  end

  root to: 'site#index'
end
