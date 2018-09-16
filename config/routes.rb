# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :shops do
        resources :products do
          resources :line_items
        end
        resources :orders do
          resources :line_items
        end
      end
    end
  end
end
