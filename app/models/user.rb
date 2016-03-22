class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,:recoverable#, :confirmable

  enum role: {
    genenral: 0,
    admin: 1,
  }

  validates :email, uniqueness:true
  validates :email, presence:true

  has_many :rents, dependent: :destroy
  has_many :comments, dependent: :destroy
end
