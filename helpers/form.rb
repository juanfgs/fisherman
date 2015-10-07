module Helpers
  class Form
    attr_accessor :fields, :html, :bootstrap
    
    def initialize(bootstrap = false)
      @bootstrap = bootstrap
      @fields = []
      @html = ''
    end

    def add_field(type, name = nil, klass = nil, value = nil, id = nil)
      if @bootstrap
        klass += " form-control"
      end
      field = ''
      case type.to_s
      when :text.to_s
        field = TextField.new(name, klass, value, id)
      when :select.to_s
        field = SelectField.new(name, klass, value, id)
      end
      
      @fields << field
    end
    
    def render
      @fields.each do |field|
        unless field.nil?
          @html << field.to_s
        end
      end
      @html
    end
    
  end

  class Field
    attr_accessor :klass, :name, :value, :id, :html
    def initialize(name, klass,value,id)
      @name = name      
      @klass = klass
      @value = value
      @id = id
    end


  end

  class TextField < Field
    def initialize(name,klass,value,id)
      super(name,klass,value,id)
      build_html
    end

    def build_html
      @html = "<input type=\"text\" name=\"#{name}\" class=\"#{klass}\", value=\"#{value}\" id=\"#{id}\"/>"      
    end

    def to_s
      @html
    end
    
  end

  class SelectField < Field
    def initialize(name,klass,value,id)
      
      if value.nil? && !value.is_a?(Array)
        raise ArgumentError
      end
      
      super(name,klass,value,id)
      build_html
    end

    def build_html
      @html = "<select name=\"#{name}\">"
      @value.each do |value|
        if value[:label].nil?
          value[:label] = value[:value]
        end
        
        @html += "<option value=\"#{value[:value]}\">#{value[:label]}</option>"
      end
      @html += "</select>"
    end

    def to_s
      @html
    end
    
  end  
  
end
