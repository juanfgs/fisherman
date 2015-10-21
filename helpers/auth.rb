module Helpers
  class Auth
    
    def self.add_strategy
      Warden::Strategies.add(:password) do

        def valid?
          params['username'] && params['password']
        end

        def authenticate!
          user = User.find_by(username: params['username'])
          if user.nil?
            fail!("Username does not exist")
          elsif user.authenticate(params['password'])
            success!(user)
          else
            fail!("Could not login")
          end
        end
        
      end
    end
    
    def self.get_user()
      env['warden'].user
    end
    
  end
end
