class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.references :contact, index: true
      t.belongs_to :user, index: true
      t.text :comment
      t.timestamps :null => false
    end
  end
end
