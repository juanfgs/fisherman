require 'uri'

class Contact < ActiveRecord::Base
  validates :url, presence: true, format: {:with =>  URI::regexp(%w(http https)), :message =>  'Must be a valid web address' }

  belongs_to :user
  has_many :comments
  
  def self.status_values
    [
      {:value => 'not-contacted', :label => 'Not contacted'},
      {:value => 'pending', :label => 'Awaiting answer'},
      {:value => 'rejected', :label => 'Rejected'},
      {:value => 'need-info', :label => 'Needs additional info'}
    ]
  end
end
