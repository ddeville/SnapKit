require 'sinatra'
require 'uri'
require 'haml'

helpers do
  def json_error(error)
    content_type 'application/json'
    {:error => error}.to_json;
  end
  
  def snap(params)
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
    @phantomjs.userAgent = params[:user_agent];

    @websnap = @phantomjs.websnap();
    halt 500, json_error("The websnap could not be processed (#{@phantomjs.snappingError})") unless (@websnap && @websnap.image);
    
    @websnap
  end
end

before '/snap' do
  @phantomjs = SnapKit::Phantomjs.new()
end

get '/snap' do
  @websnap = snap(params)
  
  if request.accept? 'text/html'
    content_type 'text/html'
    return haml(:snap);
  end
  
  if request.accept? 'application/json'
    content_type 'application/json'
    return @websnap.to_json;
  end
  
  halt 406;
end
