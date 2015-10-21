require 'pp'

module Helpers
  class Form
    attr_accessor :fields, :html, :wrap, :options
    
    def initialize( options = {} )
      @fields = []
      @html = ''
      @wrap = options[:wrap]
      @options = options
      open_form
    end

    def open_form
      @html += "<form action=\"#{options[:action]}\" method=\"#{options[:method]}\">\n"
    end
    
    def close_form
      @html += "</form>"
    end
    
    def add_field(type, name, options = nil)
      unless options.instance_of? Hash
        options = {}
      end
      
      unless @wrap.nil? && !options[:wrap].nil?
        options[:wrap] = @wrap
      end
      case type.to_s
      when :text.to_s
        @field = TextField.new(name, options )
      when :select.to_s
        @field = SelectField.new(name, options )
      when :textarea.to_s
        @field = TextAreaField.new(name, options )
      when :hidden.to_s
        @field = HiddenField.new(name, options )        
      when :checkbox.to_s
        @field = CheckboxField.new(name, options )
      when :password.to_s
        @field = PasswordField.new(name, options )        
      when :submit.to_s
        @field = SubmitField.new(name, options )                        
      end
      
      @fields << @field
    end
    
    def render
      @fields.each do |field|
        unless field.nil?
          @html << field.to_s
        end
      end
      close_form
      @html
    end
    
  end

  class Field
    attr_accessor :name, :options, :html
    
    def initialize(name, options)
      @name = name
      @options = options
      @html = ''
      
      unless @options[:wrap].nil?
        @html += WrapField.new(name,@options[:wrap]).to_s
      end
      
      unless @options[:label].nil?
        @html += "<label for=\"#{@name}\">#{@options[:label]}</label>\n"
      end
      
      build_html
      
      unless @options[:wrap].nil?      
        @html += CloseWrapField.new(name,@options[:wrap]).to_s
      end
    end

    def to_s
      @html 
    end
  end

  class TextField < Field
    
    def build_html
      @html += "<input type=\"text\" name=\"#{@name}\" placeholder=\"#{@options[:placeholder]}\" class=\"#{@options[:class]}\" value=\"#{@options[:value]}\" id=\"#{@options[:id]}\"/>\n"
    end

  end

  class PasswordField < Field

    def build_html
      @html += "<input type=\"password\" name=\"#{@name}\" placeholder=\"#{@options[:placeholder]}\" class=\"#{@options[:class]}\" value=\"#{@options[:value]}\" id=\"#{@options[:id]}\"/>\n"
    end    

  end
  
  class TextAreaField < Field

    def build_html
      @html += "<textarea name=\"#{@name}\" class=\"#{options[:class]}\" id=\"#{options[:id]}\" >#{options[:value]}</textarea>\n"
    end

  end


    class HiddenField < Field

    def build_html
      @html += "<input type=\"hidden\" name=\"#{@name}\" value=\"#{@options[:value]}\" id=\"#{@options[:id]}\"/>\n"
    end

  end

  class CheckboxField < Field

    def build_html
      value = !options[:value].nil? ? options[:value] : @name
      checked = options[:checked] ? 'checked="checked"' : ''
      @html += "<input type=\"checkbox\" value=\"#{value}\" class=\"#{@options[:class]}\" id=\"#{@options[:id]}\" #{checked} name=\"#{@name}\"/>#{@name}\n"
    end

  end  

  class SubmitField < Field
    def build_html
      @html += "<input type=\"submit\" value=\"#{options[:value]}\" name=\"#{name}\" class=\"#{options[:class]}\" id=\"#{options[:id]}\"  />"
    end
    
  end

  class SelectField < Field

    def build_html
      if @options[:values].nil?
        raise ArgumentError, ":values must be a non-empty array"
      end

      @html += "<select name=\"#{@name}\" class=\"#{@options[:class]}\">\n"
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
      @html = "<#{@options[:element]} class=\"#{@options[:class]}\" id=\"#{@options[:id]}\">"
    end
  end
  
  class CloseWrapField < Field
    def build_html
      @html = "</#{@options[:element]}>\n"
    end
  end  
  
end
