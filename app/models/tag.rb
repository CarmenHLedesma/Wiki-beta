class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :name, message: 'El campo no puede quedar en blanco'
end
