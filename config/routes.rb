Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  controller :site_input do
    post '/project_description', action: :project_description
  end
end
