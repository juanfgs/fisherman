require 'sinatra'
require 'sinatra/flash'
require 'mysql2'
require 'active_record'
require 'warden'

Dir["./models/*.rb"].each { |file| require file }
Dir["./controllers/*.rb"].each { |file| require file }
Dir["./helpers/*.rb"].each { |file| require file }

class Fisherman < Sinatra::Application
  enable :sessions
  secret = File.open('.session_secret').read
  if secret
    set :session_secret, secret
  end
  ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
  ActiveRecord::Base.establish_connection(:development)

  #Authentication stuff
  use Warden::Manager do |config|
    config.serialize_into_session {|user| user.id}

    config.serialize_from_session{|id| User.find(id)}

    config.scope_defaults :default, strategies: [:password], action: 'users/unauthenticated'
  
    config.failure_app = self
  end
  
  Helpers::Auth.add_strategy
  
  Warden::Manager.before_failure do |env, opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  before /(?!\/(users))/ do
      env['warden'].authenticate!
  end

  
  register Fisherman::Contacts
  register Fisherman::Users  
  register Fisherman::Comments  
  register Fisherman::Dashboard
  register Sinatra::Flash  


  
end



