require 'sinatra'
require 'haml'

enable :inline_templates

before do
  content_type 'text/html';
end

get '/' do
  haml :index
end

__END__
@@ layout
%html
  %body
    = yield

@@ index
%form{:action => "/snap", :method => "get"}
  %ul
    %li
      %label{:for => "url"} URL:
      %input{:type => "text", :name => "url", :class => "text"}
    %li
      %label{:for => "viewport-width"} Viewport Width:
      %input{:type => "text", :name => "viewport_width", :class => "text"}
    %li
      %label{:for => "user-agent"} User Agent:
      %input{:type => "text", :name => "user_agent", :class => "text"}
  %input{:type => "submit", :value => "Send", :class => "button"}
