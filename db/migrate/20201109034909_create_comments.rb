class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :user_id
      t.integer :bit_id
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :bit_id
  end
end
