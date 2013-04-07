# This is a simple Ruby interface around the phantomjs process execution.
# The websnap function returns a Websnap object.

require 'open3'
require 'json'

module SnapKit
  
  class Phantomjs
    
    attr_accessor :url
    attr_accessor :viewportWidth
    attr_accessor :userAgent
    
    attr_reader :snappingError
    
    PHANTOMJS_PATH = (ENV['RACK_ENV'] == 'production') ? 'phantomjs' : File.expand_path('../../vendor/phantomjs/bin/phantomjs', __FILE__);
    CAPTUREJS_PATH = File.expand_path('../phantomjs/capture.js', __FILE__);
    
    def websnap()
      parameters = "-url #{@url}"
      parameters << " -viewport-width #{@viewportWidth}" if @viewportWidth
      parameters << " -user-agent #{@userAgent}" if @userAgent
      
      cmd = "#{PHANTOMJS_PATH} #{CAPTUREJS_PATH} #{parameters}"
      
      stdin, stdout, stderr, wait_thread = Open3.popen3(cmd);
      
      response = stdout.read();
      @snappingError = stderr.read();
      
      stdin.close;
      stdout.close;
      stderr.close;
      
      exit_status = wait_thread.value;
      return nil unless exit_status == 0
      
      begin
        responseJSON = JSON.parse response;
      rescue JSON::JSONError
        @snappingError = "There was an unknown error while parsing the response from PhantomJS";
        return nil;
      end
      
      WebSnap.new(responseJSON['title'], responseJSON['imageData']);
    end
    
  end
  
end
