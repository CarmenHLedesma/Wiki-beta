class AddTreeStructure < ActiveRecord::Migration
  def change
    add_column :posts, :parent_id, :integer
    add_foreign_key :posts, :posts, column: :parent_id
  end
end
