class Post < ActiveRecord::Base
  belongs_to :user
  # using acts_as_taggable_on
  acts_as_taggable_on :tags

  #has_many :posts_categories
   #has_and_belongs_to_many :categories, :join_table => 'posts_categories'
  #FUNCIONANDO
  has_attached_file :document
  validates_attachment_content_type :document, :content_type => [ 'application/pdf','text/plain']

#  validates_attachment :document, content_type: { content_type: "application/pdf" }, :path => "documentos/imputaciones/:id_:filename"
 # validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) },
  # Active Record Associations
  belongs_to :parent, class_name: 'Post', inverse_of: :children
  has_many :children, class_name: 'Post', foreign_key: :parent_id, inverse_of: :parent

end
