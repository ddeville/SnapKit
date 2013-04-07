class Phantomjs
  
  attr_accessor :url
  attr_accessor :userAgent
  attr_accessor :viewportWidth
  
  def Initialize(url, viewportWidth, userAgent)
    @url = url;
    @viewportWidth = viewportWidth;
    @userAgent = userAgent;
  end
  
  WEBSNAPJS_PATH = File.expand_path('../websnap.js', __FILE__);
  
  def websnap
    parameters = "-url #{@url}"
    parameters << " -viewport-width #{@viewportWidth}" if @viewportWidth
    parameters << " -useragent #{@userAgent}" if @userAgent
    
    cmd = "phantomjs #{WEBSNAPJS_PATH} #{parameters}"
    
    response = `#{cmd}`;
    response
  end
  
end
