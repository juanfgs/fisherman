require 'json'

module Controllers
  module Comments

    def self.registered(app)
      
      app.get '/contacts/:id/comments' do
        @comments = Contact.find(params[:id]).comments

        content_type :json
        
        @comments.to_json
      end      


      app.post '/comments/add' do

        @comment = Comment.new
        @comment.comment = params[:comment]
        @comment.contact_id = params[:contact_id]
        if @comment.save
          flash[:message] = "Comment was saved"
          redirect '/contacts/'
        else
          flash[:errors] = @comment.errors.full_messages
          redirect '/contacts/'
        end

      end      
      
    end
  end
end
