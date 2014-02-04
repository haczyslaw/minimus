# encoding: utf-8

Minimus::Router.new(
  '/posts' => 'posts#index',
  '/' => 'posts#index',
  '/post' => 'posts#show'
)

