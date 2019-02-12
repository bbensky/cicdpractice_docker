require 'sinatra'

get '/' do
  if params[:name]
    "Hello #{params[:name]}!"
  else
    "Hello World!"
  end
end

get '/:name' do
  "Hello #{params[:name]}!"
end
