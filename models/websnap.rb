module SnapKit
  
  class WebSnap
    
    attr_accessor :title
    attr_accessor :image
    
    def initialize(title, image)
      @title = title;
      @image = image;
    end
    
    def to_json()
      {:title => @title, :image => @image}.to_json;
    end
    
  end
  
end
