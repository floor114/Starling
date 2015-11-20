class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :name, presence: true, length: { maximum: 18 }
  has_many :posts
  has_attached_file :avatar,:default_url => "missing_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  acts_as_liker
  acts_as_followable
  acts_as_follower
end
