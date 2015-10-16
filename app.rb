require 'sinatra'
require 'sinatra/flash'
require 'active_record'

Dir["./models/*.rb"].each { |file| require file }
Dir["./controllers/*.rb"].each { |file| require file }
Dir["./helpers/*.rb"].each { |file| require file }

class Fisherman < Sinatra::Application
  enable :sessions
  

  ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
  ActiveRecord::Base.establish_connection("development")
  register Fisherman::Controllers::Contacts
  register Fisherman::Controllers::Comments  
  register Fisherman::Controllers::Dashboard
  register Sinatra::Flash  


  
end



