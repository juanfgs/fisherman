require 'minitest/autorun'
require 'minitest/spec'
require 'form'
require 'nokogiri'

describe Helpers::Form do
  before do
    @form = Helpers::Form.new()
  end

  it "produces a valid text element from a hash describing all it's properties" do
    @form.add_field :text, "foobar", { :id => 'firstfield', :class => 'klass', :value => 'asdasd', :placeholder => 'bubu'}
    doc = Nokogiri::HTML( @form.render )
    doc.errors.must_be_empty
    end
    
  it "produces a valid text element from a hash describing some properties" do
    @form.add_field "text", "foobar", { :id => 'firstfield', :class => 'klass' }

    doc = Nokogiri::HTML( @form.render )
    doc.errors.must_be_empty
  end
  
  it "produces a valid select element with several options" do
    @form.add_field "select", "foobar", {:values => [{:value => 'uno'}, {:value => 'dos'}, {:value => 'tres', :label => 'Tres'}]}

    doc = Nokogiri::HTML( @form.render )
    doc.errors.must_be_empty
  end
  
  
end
