require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, presence: true
  validates :password, presence: true

  has_many :contacts
  
  def hash_password(secret)
    salt = BCrypt::Engine.generate_salt
    password = BCrypt::Engine.hash_secret(secret, salt)
    "#{password}:#{salt}"
  end
  
  def authenticate(secret)
    if check_password(secret)
      true
    else
      nil
    end
  end

  def check_password(secret)
    current_secret,salt = self.password.split(':')
    current_secret == BCrypt::Engine.hash_secret(secret, salt) 
  end
  
end
