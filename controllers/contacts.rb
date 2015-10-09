module Controllers
  module Contacts

    def self.registered(app)

      app.get '/contacts/' do
        erb :'contacts/index', :format => :html5
      end

      app.get '/contacts/add' do
        @title = 'Add Contacts'        
        @form = Helpers::Form.new({:element => 'div', :class => 'form-group'})
        @form.add_field :text, 'url', {:class => 'form-control', :label => 'Url'}
        @form.add_field(:select, 'status',
                        {
                          :values => [{:value => 'uno'}, {:value => 'dos'}, {:value => 'tres', :label => 'Tres'}],
                          :class => 'form-control',
                          :label => 'Status'
                        }
                       )
        
        

        erb :'contacts/add'
      end      

    end
  end
end
