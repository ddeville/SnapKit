require 'json'

before do
  content_type 'application/json';
end

get '/' do
  snapRequest = {'snap' => {
    :method => 'GET',
    :uri => '/snap',
    :parameters => [
        'url', 'viewport_width', 'user_agent'
      ],
  }};
  {'requests' => [snapRequest]}.to_json;
end
