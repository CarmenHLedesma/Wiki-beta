class Post < ActiveRecord::Base
  belongs_to :user
  # using acts_as_taggable_on
  acts_as_taggable_on :tags

  validates_presence_of :title, :text, :user, message: 'El campo no puede quedar en blanco'

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

  scope :search, -> (title, text, document, tag_list) do
    scope = self.all

    if title.present?
      scope = scope.where("title LIKE ?", "%#{title}%")
    end
    if text.present?
      scope = scope.where("text LIKE ?", "%#{text}%")
    end
    if document.present?
      # scope = scope.where(document_file_name: document_file_name)
      scope = scope.where("document_file_name IS NOT NULL")
    end
    if tag_list.present?
      scope = scope.joins("LEFT JOIN taggings ON taggings.taggable_id = posts.id where taggings.taggable_type = 'Post' and taggings.tag_id = #{tag_list}")
    end

    return scope
  end

end
# def self.search(title, text, document, tag_list)
#   # where("title LIKE ? OR text LIKE ? OR document LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
#   yo = self.all
#
#   if title.present?
#     yo = yo.where("title LIKE ?", "%#{title}%")
#   end
#   if text.present?
#     yo = yo.where("text LIKE ?", "%#{text}%")
#   end
#   if document.present?
#     yo = yo.where("document IN ?", "#{document}")
#   end
#   if tag_list.present?
#     yo = yo.joins("LEFT JOIN taggings ON taggings.taggable_id = posts.id where taggings.taggable_type = 'Post' and taggings.tag_id = #{tag_list}")
#   end
#
#   return yo
# end
#if title.present?
  #       where("title LIKE ?", "%#{title}%")
  #     end
  #     if text.present?
  #       where("text LIKE ?", "%#{text}%")
  #     end
  #     if document_file_name.present?
  #       where( document_file_name: document_file_name )
  #     end
  #     if tag_list.present?
  #       joins("LEFT JOIN taggings ON taggings.taggable_id = posts.id where taggings.taggable_type = 'Post' and taggings.tag_id = #{tag_list}")
  #     end
  #
  # end