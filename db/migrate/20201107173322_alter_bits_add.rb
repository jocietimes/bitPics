class AlterBitsAdd < ActiveRecord::Migration[5.2]
  def change
    add_column :bits, :user_id, :integer
    add_index :bits, :user_id
  end
end
