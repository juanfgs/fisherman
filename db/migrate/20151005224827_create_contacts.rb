class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, :null => true
      t.string :url, :null => false
      t.string :description, :null =>true
      t.string :status, :default => 'not-contacted'
      
      t.timestamps :null => false
      
    end
  end
end
