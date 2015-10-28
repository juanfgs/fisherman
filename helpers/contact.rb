module Helpers
  
  class Contact
    # Calculate the "heat" class of a given date
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

    def self.status_label( status )
      @statuses = ::Contact.status_values
      @status = @statuses.detect {|e| e[:value] == status}
      @status[:label]
    end
    
  end
  
end
