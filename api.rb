require 'byebug'
require 'sinatra'
require_relative 'sphereio'

get '/matching_color/:color' do
  Sphereio.product_with_matching_color(params['color'])
end
