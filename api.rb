require 'byebug'
require 'sinatra'
require_relative 'sphereio'
require_relative 'paypal'

get '/matching_color/:color' do
  content_type :json
  Sphereio.product_with_matching_color(params['color']).to_json
end

#curl -X POST http://localhost:9292/make_payment/123 -d "name=shirt&price=40.23&currency=EUR&quantity=1"
post '/make_payment/:product_id' do
  content_type :json
  product_name = params['name']
  product_price = params['price']
  product_currency = params['currency']
  product_quantity = params['quantity']
  response = Paypal.make_payment(params['product_id'], product_name, product_price, product_currency, product_quantity)
  msg = ""
  if response
    msg = "Payment created successfully"
    status 200
  else
    msg = "Error while creating payment"
    status 400
  end
  msg.to_json
end
