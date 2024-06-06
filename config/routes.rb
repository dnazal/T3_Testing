# frozen_string_literal: true

Rails.application.routes.draw do
  # Rutas generales
  root 'pages#index'
  get 'pages/index'
  get '/', to: 'pages#index'
  get '/contacto', to: 'contact_message#mostrar'
  get '/accesorios', to: 'pages#accessorios'
  get '/reserva', to: 'pages#reserva'

  # Rutas de products
  get 'products/index', to: 'products#index'
  get 'products/leer/:id', to: 'products#leer'
  get 'products/crear', to: 'products#crear'
  post 'products/insertar', to: 'products#insertar'
  get 'products/actualizar/:id', to: 'products#actualizar'
  patch 'products/actualizar/:id', to: 'products#actualizar_producto'
  post 'products/editar/:id', to: 'products#editar'
  delete 'products/eliminar/:id', to: 'products#eliminar'
  post 'products/insert_deseado/:product_id', to: 'products#insert_deseado'

  # Rutas de usuario y devise
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' },
                     path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  get '/users/show', to: 'users#show', as: 'user_show'
  get '/users/deseados', to: 'users#deseados', as: 'user_deseados'
  get '/users/mensajes', to: 'users#mensajes', as: 'user_mensajes'
  delete '/users/eliminar_deseado/:deseado_id', to: 'users#eliminar_deseado', as: 'user_eliminar_deseado'
  patch '/users/actualizar_imagen', to: 'users#actualizar_imagen', as: 'user_actualizar_imagen'

  # Rutas de reviews
  resources :reviews, only: %i[show create update destroy]
  post 'review/insertar', to: 'review#insertar'
  patch 'review/actualizar/:id', to: 'review#actualizar_review'
  delete 'review/eliminar/:id', to: 'review#eliminar'

  # Rutas de messages
  get 'messages/leer/:id', to: 'message#leer', as: 'message_leer'
  post 'message/insertar', to: 'message#insertar'
  delete 'message/eliminar', to: 'message#eliminar'

  # Rutas de solicitud
  post 'solicitud/insertar', to: 'solicitud#insertar'
  get 'solicitud/index', to: 'solicitud#index'
  get 'solicitud/leer/:id', to: 'solicitud#leer'
  delete 'solicitud/eliminar/:id', to: 'solicitud#eliminar'
  patch 'solicitud/actualizar/:id', to: 'solicitud#actualizar'

  # Rutas de contacto
  post 'contacto/crear', to: 'contact_message#crear'
  patch 'contacto/actualizar/:id', to: 'contact_message#actualizar'
  delete 'contacto/eliminar/:id', to: 'contact_message#eliminar'
  delete 'contacto/limpiar', to: 'contact_message#limpiar'

  # Rutas del carro de compras
  get 'carro', to: 'shopping_cart#show'
  get 'carro/detalle', to: 'shopping_cart#details'
  post 'carro/insertar_producto', to: 'shopping_cart#insertar_producto'
  post 'carro/comprar_ahora', to: 'shopping_cart#comprar_ahora'
  delete 'carro/eliminar_producto/:product_id', to: 'shopping_cart#eliminar_producto'
  delete 'carro/limpiar', to: 'shopping_cart#limpiar'
  post 'carro/realizar_compra', to: 'shopping_cart#realizar_compra'
end
