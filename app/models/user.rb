class User < ActiveRecord::Base
has_many :posts
has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '100x100#' }, :default_url => '/images/:style/missing.png'
validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable
devise :database_authenticatable,
  :registerable,
  :recoverable,
  :rememberable,
  :trackable,
  :validatable

  def full_name
    if self.name.blank?
      self.email
    else
      self.name
    end
  end


end
