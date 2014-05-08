Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :page_videos do
    resources :page_videos, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :page_videos, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :page_videos, :except => :show do
        member do
          post :insert_to_page
        end
        collection do
          post :update_positions
        end
      end
    end
  end

end
