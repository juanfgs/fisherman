module Helpers
  
  class Contact
    def self.date_heat( date )
      diff = Time.now - date
      if date.to_i < 10
        'green'
        elsif date.to_i < 60
        'orange'
      else
        'red'
      end
    end
  end
  
end
