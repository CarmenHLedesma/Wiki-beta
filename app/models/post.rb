class Post < ActiveRecord::Base
  belongs_to :user
  # Active Record Associations
  belongs_to :parent, class_name: 'Post', foreign_key: :parent_id
  has_many :children, class_name: 'Post', foreign_key: :parent_id
end
