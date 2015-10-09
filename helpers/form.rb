require 'pp'

module Helpers
  class Form
    attr_accessor :fields, :html, :wrap
    
    def initialize( wrap = nil )
      @fields = []
      @html = ''
      @wrap = wrap
      
    end

    def add_field(type, name = nil, options)
      unless @wrap.nil? && !options[:wrap].nil?
        options[:wrap] = @wrap
      end
      case type.to_s
      when :text.to_s
        @field = TextField.new(name, options )
      when :select.to_s
        @field = SelectField.new(name, options )
      end
      
      @fields << @field
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
    attr_accessor :name, :options, :html
    
    def initialize(name, options)
      @name = name
      @options = options
      @html = ''
      
      unless options[:wrap].nil?
        @html += WrapField.new(name,options[:wrap]).to_s
      end
      
      unless options[:label].nil?
        @html += "<label for=\"#{name}\">#{options[:label]}</label>\n"
      end
      
      build_html
      
      unless options[:wrap].nil?      
        @html += CloseWrapField.new(name,options[:wrap]).to_s
      end
    end

    def to_s
      @html 
    end
  end

  class TextField < Field

    def build_html
      @html += "<input type=\"text\" name=\"#{@name}\" class=\"#{@options[:class]}\" value=\"#{@options[:value]}\" id=\"#{@options[:id]}\"/>\n"
    end

  end

  class SelectField < Field

    def build_html
      
      if @options[:values].nil?
        raise ArgumentError, ":values must be a non-empty array"
      end

      @html += "<select name=\"#{name}\" class=\"#{@options[:class]}\">\n"
      @options[:values].each do |value|
        if value[:label].nil?
          value[:label] = value[:value]
        end
        selected = ''
        unless value[:selected].nil?
          selected = 'selected="selected"'          
        end

        @html += "<option value=\"#{value[:value]}\" #{selected}>#{value[:label]}</option>\n"
      end
      @html += "</select>\n"
    end
    
  end  

  class WrapField < Field
    def build_html
      @html = "<#{options[:element]} class=\"#{options[:class]}\" id=\"#{options[:id]}\">"
    end
  end
  
  class CloseWrapField < Field
    def build_html
      @html = "</#{options[:element]}>\n"
    end
  end  
  
end
