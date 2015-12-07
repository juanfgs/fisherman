class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.belongs_to :user, index: true      
      t.string :name, :null => true
      t.string :email, :null => true      
      t.string :url, :null => false, :unique => true
      t.text :description, :null =>true
      t.string :status, :default => 'not-contacted'

      t.timestamps :null => false
      
    end
  end
end
