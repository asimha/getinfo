class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #associations
  has_many :posts, :dependent => :destroy
  has_many :members
  has_many :groups, :dependent => :destroy, :through => :members
  has_many :comments

  acts_as_follower
  
end
