Rails.application.routes.draw do
  get '/trigger', to: 'trigger#index'
end