module Users

  def self.registered(app)

    app.get '/users/login' do
      @title = 'Login'

      @form = Helpers::Form.new({:method => 'POST', :wrap => {:element => 'div', :class => 'form-group'}})
      @form.add_field :text, 'username', {:class => 'form-control', :label => 'Username'}
      @form.add_field :password, 'password', {:class => 'form-control', :label => 'Password'}
      @form.add_field :submit, 'login', {:value => 'Log in ', :class => 'btn btn-primary pull-right'}
      
      erb :'users/login', :layout =>  :layout_auth
    end

    app.post '/users/login' do
      env['warden'].authenticate!
      flash[:success] = env['warden'].message
      
      if session[:return_to].nil?
        redirect '/'
      else
        redirect session[:return_to]
      end
    end
    
    app.get '/users/sign_up' do
      @title = 'Sign Up'

      @form = Helpers::Form.new({:method => 'POST', :wrap => {:element => 'div', :class => 'form-group'}})
      @form.add_field :text, 'username', {:class => 'form-control required', :label => 'Username'}
      @form.add_field :password, 'password', {:class => 'form-control required', :label => 'Password'}
      @form.add_field :text, 'name', {:class => 'form-control ', :label => 'Name'}                        
      @form.add_field :text, 'email', {:class => 'form-control ', :label => 'Email'}
      @form.add_field :submit, 'login', {:value => 'Sign Up! ', :class => 'btn btn-primary pull-right'}
      
      erb :'users/sign_up', :layout =>  :layout_auth
    end

    app.post '/users/sign_up' do
      @user = User.new
      @user.username = params[:username]
      @user.password = @user.hash_password(params[:password])
      @user.name = params[:name]
      @user.email = params[:email]
      if @user.save
        flash[:message] = "Contact was saved successfully"
        redirect '/'
      else
        flash[:errors] = @user.errors.full_messages
        redirect '/users/sign_up'
      end        
      
    end

    app.get '/users/logout' do
      env['warden'].raw_session.inspect
      env['warden'].logout
      flash[:success] = 'Successfully logged out'
      redirect '/'
    end
    
    app.post '/users/unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path]
      puts env['warden.options'][:attempted_path]
      flash[:error] = env['warden'].message || "You must log in"
      redirect '/users/login'
    end

    app.get '/protected' do
      env['warden'].authenticate!
      @current_user = env['warden'].user
      erb :protected
    end


    
  end
end

