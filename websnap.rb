require 'sinatra'
require 'json'
require 'uri'

helpers do
  WEBSNAPJS_PATH = File.expand_path('../websnap.js', __FILE__);
  
  def json_error(error)
    {:error => error}.to_json;
  end
end

before do
  content_type 'application/json';
end

get '/' do
  snapRequest = {'snap' => {
    :method => 'GET',
    :uri => '/snap',
  }};
  {'requests' => [snapRequest]}.to_json;
end

get '/snap' do
  url = params[:url];
  halt 400, json_error('The URL is a required parameter') unless url;
  
  begin
    url = URI.parse url
  rescue URI::InvalidURIError
    halt 400, json_error('The URL is malformed');
  end
  
  halt 400, json_error('The URL is not valid') unless url.kind_of? URI::HTTP;
  
  response = `phantomjs #{WEBSNAPJS_PATH} -url #{url.to_s}`;
  
  puts 'RESPONSE'
  puts response
  
  begin
    responseJSON = JSON.parse response;
  rescue JSON::JSONError
    halt 500, json_error('The websnap could not be processed (error parsing)');
  end
  
  title = responseJSON['title'];
  image = responseJSON['imageData'];
  
  halt 500, json_error('The websnap could not be processed (missing values in the response)') unless (responseJSON && image);
  
  {:title => title, :image => image}.to_json;
end