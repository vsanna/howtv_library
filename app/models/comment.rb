class Comment < ActiveRecord::Base
  belongs_to :book, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
