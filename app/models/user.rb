class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,:recoverable#, :confirmable

  enum role: {
    general: 0,
    admin: 1,
  }

  validates :email, uniqueness:true
  validates :password_confirmation, presence:true
  validates :family_name, presence:true
  validates :given_name, presence:true
  validates :role, presence:true

  has_many :rents, dependent: :destroy
  has_many :comments, dependent: :destroy
end
