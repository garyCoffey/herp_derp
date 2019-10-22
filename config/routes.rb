Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  controller :site do
    post '/project_description', action: :project_description
    get '/architecture', action: :architecture
  end

  root :to=> "site#index"
end
