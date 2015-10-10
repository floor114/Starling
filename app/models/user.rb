class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :name, presence: true
  has_many :posts
  has_attached_file :avatar,:default_url => "noavatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
