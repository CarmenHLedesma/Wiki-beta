class Category < ActiveRecord::Base
  #has_many :posts_categories
  has_and_belongs_to_many :posts
end
