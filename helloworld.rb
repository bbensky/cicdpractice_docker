require 'sinatra'

get '/' do
  "Hello World!"
end

get '/cleveland' do
  "Hello Cleveland!"
end

get '/please' do
  "Hello Please!"
end

get '/morethanworld' do
  "Hello Universe!"
end

get '/:name' do
  "Hello #{params[:name]}!"
end

get '/:first_name/:last_name' do
  "Hello #{params[:first_name]} #{params[:last_name]}!"
end
