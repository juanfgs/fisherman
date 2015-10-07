require 'sinatra'
require 'active_record'

Dir["./models/*.rb"].each { |file| require file }
Dir["./controllers/*.rb"].each { |file| require file }
Dir["./helpers/*.rb"].each { |file| require file }

class Fisherman < Sinatra::Application


  register Fisherman::Controllers::Contacts
  register Fisherman::Controllers::Dashboard


  
end



