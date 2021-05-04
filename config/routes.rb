Rails.application.routes.draw do
  resources :trains do
    resources :tracks
  end
end
