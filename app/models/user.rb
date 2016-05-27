class User < ActiveRecord::Base
has_many :posts

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
