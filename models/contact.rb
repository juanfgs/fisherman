require 'uri'

class Contact < ActiveRecord::Base
  validates :url, presence: true, format: {:with =>  URI::regexp(%w(http https)), :message =>  'Must be a valid web address' }, uniqueness: true
  validates :email,  format: {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }, uniqueness: true
  
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
 
