class AddPicsToBits2 < ActiveRecord::Migration[5.2]
  def change
    add_column :bits, :pics, :string
  end
end
