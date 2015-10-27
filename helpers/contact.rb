module Helpers
  
  class Contact
    def self.date_heat( date )
      diff = Time.now - date

      if diff.to_i < 45000
        'green'
        elsif diff.to_i < 90000
        'orange'
      else
        'red'
      end
    end
  end
  
end
