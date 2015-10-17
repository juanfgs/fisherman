module Controllers
  module Users

    def self.registered(app)

      app.get '/users/login' do
        @title = 'Login'

        @form = Helpers::Form.new({:method => 'POST', :wrap => {:element => 'div', :class => 'form-group'}})
        @form.add_field :text, 'username', {:class => 'form-control', :label => 'Username'}
        @form.add_field :text, 'password', {:class => 'form-control', :label => 'Password'}
        @form.add_field :submit, 'login', {:value => 'Log in ', :class => 'btn btn-primary pull-right'}
        
        erb :'users/login', :layout =>  :layout_auth
      end
      app.get '/users/sign_up' do
        @title = 'Sign Up'

        @form = Helpers::Form.new({:method => 'POST', :wrap => {:element => 'div', :class => 'form-group'}})
        @form.add_field :text, 'username', {:class => 'form-control required', :label => 'Username'}
        @form.add_field :text, 'password', {:class => 'form-control required', :label => 'Password'}
        @form.add_field :text, 'name', {:class => 'form-control ', :label => 'Name'}                        
        @form.add_field :text, 'email', {:class => 'form-control ', :label => 'Email'}
        @form.add_field :submit, 'login', {:value => 'Sign Up! ', :class => 'btn btn-primary pull-right'}
        
        erb :'users/sign_up', :layout =>  :layout_auth
      end

      app.post '/users/sign_up' do
        
      end

      app.post '/users/login' do

      end

    end
  end
end
