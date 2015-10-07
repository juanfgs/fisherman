module Controllers
  module Contacts

    def self.registered(app)

      app.get '/contacts/' do
        erb :'contacts/index', :format => :html5
      end

      app.get '/contacts/add' do
        @form = Helpers::Form.new(true)
        @form.add_field :text, 'url', 'form-control'
        @form.add_field :select, 'status', 'form-control', [{:value => 'active', }]
        erb( :'contacts/add', :locals => {:form => @form} )
      end      

    end
  end
end
