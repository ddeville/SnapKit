require 'sinatra'
require 'uri'
require 'json'

helpers do
  def json_error(error)
    {:error => error}.to_json;
  end
end

before '/snap' do
  content_type 'application/json';
  @phantomjs = SnapKit::Phantomjs.new()
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
  
  websnap = @phantomjs.websnap();
  halt 500, json_error('The websnap could not be processed (missing values in the response)') unless (websnap && websnap.image);
  
  {:title => websnap.title, :image => websnap.image}.to_json;
end
