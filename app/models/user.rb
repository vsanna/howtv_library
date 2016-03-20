class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,:recoverable#, :confirmable

  enum role: %i(user admin) #

  has_many :rents, dependent: :destroy
  has_many :comments, dependent: :destroy
end
