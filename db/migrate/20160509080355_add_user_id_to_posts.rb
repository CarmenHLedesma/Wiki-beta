class AddUserIdToPosts < ActiveRecord::Migration
  def change
    change_column :posts, :user_id, :integer
    add_foreign_key :posts, :users, column: 'user_id'

    #add_reference :posts, :user, foreign_key: true

    #add_column :posts, :author_id, :integer
    #add_foreign_key :posts, :users, column: author_id
  end
end
