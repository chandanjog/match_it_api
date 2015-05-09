require 'byebug'
require 'sinatra'
require_relative 'sphereio'

get '/matching_color/:color' do
  content_type :json
  Sphereio.product_with_matching_color(params['color']).to_json
end
