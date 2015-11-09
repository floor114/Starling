class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :name, presence: true
  has_many :posts
  has_attached_file :avatar,:default_url => "noavatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_attached_file :avatar,
                    :bucket => ENV['S3_BUCKET_NAME'],
                    :url => ':s3_domain_url',
                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                    :default_url => "noavatar.png"


  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/




  acts_as_liker
  acts_as_followable
  acts_as_follower
end
