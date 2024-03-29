Photoalbum::Application.routes.draw do
  resources :albums do
    member { post :add_image; post :update_album}
    collection {post :remove_image; post :remove_album}
  end
  root :to => 'albums#index'
end
