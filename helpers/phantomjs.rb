# This is a simple Ruby interface around the phantomjs process execution.
# The websnap function returns a Websnap object.

require 'json'

module SnapKit
  
  class Phantomjs
    
    attr_accessor :url
    attr_accessor :viewportWidth
    attr_accessor :userAgent
    
    PHANTOMJS_PATH = (ENV['RACK_ENV'] == 'production') ? 'phantomjs' : File.expand_path('../../vendor/phantomjs/bin/phantomjs', __FILE__);
    CAPTUREJS_PATH = File.expand_path('../phantomjs/capture.js', __FILE__);
    
    def websnap
      parameters = "-url #{@url}"
      parameters << " -viewport-width #{@viewportWidth}" if @viewportWidth
      parameters << " -useragent #{@userAgent}" if @userAgent
      
      cmd = "#{PHANTOMJS_PATH} #{CAPTUREJS_PATH} #{parameters}"
      
      response = `#{cmd}`;
      
      begin
        responseJSON = JSON.parse response;
      rescue JSON::JSONError
        return nil;
      end
      
      WebSnap.new(responseJSON['title'], responseJSON['imageData']);
    end
    
  end
  
end
