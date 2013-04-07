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
    
    def to_xml()
      {:title => @title, :image => @image}.to_xml;
    end
    
  end
  
end
