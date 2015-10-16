class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :contact, index:true
      t.text :comment
      t.timestamp
    end
  end
end