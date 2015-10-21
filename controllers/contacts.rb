require 'json'

module Contacts

  def self.registered(app)

    app.get '/contacts/add' do

      @title = 'Add Contacts'        
      @form = Helpers::Form.new({:method => 'POST',:wrap => {:element => 'div', :class => 'form-group'}})
      @form.add_field :text, 'name', {:class => 'form-control', :label => 'Name'}        
      @form.add_field :text, 'url', {:class => 'form-control', :label => 'Web Address'}
      @form.add_field(:select, 'status',
                      {
                        :values => Contact.status_values,
                        :class => 'form-control',
                        :label => 'Status'
                      }
                     )
      @form.add_field(:textarea, 'description', {:class => 'form-control', :label => 'Description'})
      @form.add_field(:hidden, 'user_id', {:value => env['warden'].user.id })      
      @form.add_field :submit, '', {:value => 'Add Contact', :class => 'btn btn-primary pull-right'}

      erb :'contacts/add'
    end      

    app.post '/contacts/add' do
      @contact = Contact.new(params)

      if @contact.save
        flash[:message] = "Contact was saved successfully"
        redirect '/contacts/'
      else
        flash[:errors] = @contact.errors.full_messages
        redirect '/contacts/add'
      end
    end

    app.get '/contacts/' do

      
      @title = "Contacts"
      @contacts = Contact.all
      @scripts = [{:url => 'comment_form.js'}]

      @comment_form = Helpers::Form.new({:method => 'POST',:action => '/comments/add', :wrap => {:element => 'div', :class => 'form-group'}})
      @comment_form.add_field :textarea, 'comment', {:class => 'form-control', :label => 'Add Comment'}
      @comment_form.add_field :hidden, 'contact_id', {:value => params[:id]}
      @comment_form.add_field :hidden, 'user_id', {:value => env['warden'].user.id }      
      @comment_form.add_field :submit, 'add', {:value => 'Add Contact', :class => 'btn btn-primary pull-right'} 

      
      erb :'contacts/index'
    end

    app.get '/contacts/:id' do
      @contact = Contact.find(params[:id])
      @contact.to_json(:include => [{:comments => {:include => :user}}, :user] )
    end


    app.get '/' do
      @contacts = Contact.all
      @comments = Comment.all
      
      erb :'dashboard/index', :format => :html5
    end
    
  end
end

