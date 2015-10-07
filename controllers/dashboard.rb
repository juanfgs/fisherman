module Controllers
  module Dashboard

    def self.registered(app)
      app.get '/' do
        erb :'dashboard/index', :format => :html5
      end


    end
  end
end
