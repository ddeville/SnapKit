require 'uri'
require 'json'

helpers do
  def json_error(error)
    {:error => error}.to_json;
  end
end

before '/snap' do
  content_type 'application/json';
  @phantomjs = Phantomjs.new()
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
  
  @phantomjs.url = url.to_s;
  @phantomjs.viewportWidth = params[:viewport_width];
  @phantomjs.userAgent = params[:userAgent];
  
  response = @phantomjs.websnap();
  
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
