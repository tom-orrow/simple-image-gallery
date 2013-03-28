Photoalbum::Application.routes.draw do
  resources :albums do
    member { put :add_image}
  end

  match "albums/remove_image" => "albums#remove_image"
  match "albums/remove_album" => "albums#remove_album"
  root :to => 'albums#index'
end
