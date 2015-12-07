require 'json'


module Contacts

  def self.registered(app)

    app.get '/contacts/add' do

      @title = 'Add Contacts'        
      @form = Helpers::Form.new({:method => 'POST',:wrap => {:element => 'div', :class => 'form-group'}})
      @form.add_field :text, 'name', {:class => 'form-control', :label => 'Name'}        
      @form.add_field :text, 'url', {:class => 'form-control', :label => 'Web Address'}
      @form.add_field :text, 'email', {:class => 'form-control', :label => 'Email'}      
      @form.add_field(:select, 'status',
                      {
                        :values => Contact.status_values,
                        :class => 'form-control',
                        :label => 'Status'
                      }
                     )
      @form.add_field(:textarea, 'description', {:class => 'form-control summernote', :label => 'Description'})
      @form.add_field(:hidden, 'user_id', {:value => env['warden'].user.id })      
      @form.add_field :submit, '', {:value => 'Add Contact', :class => 'btn btn-primary pull-right'}
      @scripts = [{url: 'comment_form.js' }, {url: 'summernote.min.js'}]
      erb :'contacts/add'
    end      

    app.post '/contacts/add' do
      
      
      @contact = Contact.new({
                               name: params[:name],
                               url: params[:url],
                               email: params[:email],                               
                               description: params[:description],
                               user_id: params[:user_id],                               
                               status: params[:status],                               
                               
                             })

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

      @scripts = [{url: 'comment_form.js' }, {url: 'search.js'}, {url: 'summernote.min.js'}]
      
      @select_status = Helpers::SelectField.new(
        'status',
        {
          :values => Contact.status_values,
          :class => 'form-control',
        })

      @comment_form = Helpers::Form.new({:method => 'POST',:action => '/comments/add', :wrap => {:element => 'div', :class => 'form-group'}})
      @comment_form.add_field :textarea, 'comment', {:class => 'form-control summernote', :label => 'Add Comment'}
      @comment_form.add_field :hidden, 'contact_id', {:value => params[:id]}
      @comment_form.add_field :hidden, 'user_id', {:value => env['warden'].user.id }      
      @comment_form.add_field :submit, 'add', {:value => 'Add Comment', :class => 'btn btn-primary pull-right'} 

      
      erb :'contacts/index'
    end

    #View Contact
    app.get '/contacts/:id' do
      @contact = Contact.find(params[:id])
      @contact.to_json(:include => [{:comments => {:include => :user}}, :user] )
    end


    # Edit Contact
    app.post '/contacts/:id/edit' do
      @contact = Contact.find(params[:id])
      
      @contact.status = params[:status]
      
      if @contact.save
        flash[:message] = "Contact was updated"
        redirect '/contacts/'
      else
        flash[:errors] = @contact.errors.full_messages
        redirect '/contacts/'
      end            
    end

    #Delete contact
    app.get '/contacts/:id/delete' do
      @contact = Contact.find(params[:id])

      if @contact.delete
        flash[:message] = "Contact was deleted"
        redirect '/contacts/'
      else
        flash[:errors] = @contact.errors.full_messages
        redirect '/contacts/'
      end      
    end    
    

    app.get '/' do
      @title = "Fisherman"
      
      @contacts = Contact.all
      @comments = Comment.all
      
      erb :'dashboard/index', :format => :html5
    end

    app.get '/contacts/search/:terms' do

        @contacts = Contact.where("contacts.name LIKE :terms OR contacts.description LIKE :terms OR contacts.url LIKE :terms", {:terms => "%#{params[:terms]}%"}).all
        @contacts.to_json

    end
    
    app.get '/contacts/search/' do
      @contacts = Contact.all
      @contacts.to_json
    end
  end
end

