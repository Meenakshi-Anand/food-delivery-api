Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resource :user, only: [:create,:update,:index]
    patch  'user/update_contact_number' , to: 'users#update_contact_number'
    patch  'user/update_address' , to: 'users#update_address'
    get    'restaurant/:id/get_menu' , to: 'restaurants#get_menu'
    post   'restaurant/:id/set_menu' , to: 'restaurants#set_menu'
    post   'restaurant/update_delivery_range' , to: 'restaurants#update_delivery_range'
    get    'user/delivering_restaurants' , to: 'users#get_delivering_restaurants'
    post   'restaurant/:id/cart' , to: 'carts#create'
    post   'restaurant/:id/cart/:cart_id/order' , to: 'orders#create'
    patch  'restaurant/:id/cart/:cart_id/cart_status', to: 'carts#update_cart_status'
    patch  'restaurant/:id/cart/:cart_id/order/:order_id', to: 'orders#update_order_status'
    post   'restaurant/:id/cart/:cart_id/order/:order_id/review' , to: 'reviews#create'
    delete 'restaurant/:id/cart/:cart_id/order/:order_id/review/:review_id' , to: 'reviews#destroy'
    patch 'restaurant/:id/cart/:cart_id/order/:order_id/review/:review_id' , to: 'reviews#update'
    resource :session, only: [:create, :destroy,:show]
    resources :food_items
  end
end
