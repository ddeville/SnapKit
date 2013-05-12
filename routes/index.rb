require 'sinatra'
require 'haml'

before do
  content_type 'text/html';
end

get '/' do
  haml :index
end
