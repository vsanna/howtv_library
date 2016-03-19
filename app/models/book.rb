class Book < ActiveRecord::Base
  has_many :comments

  enum status: {
    broken: -2,
    before_shelf: -1,
    in_shelf: 0,
    in_use:1
  }
end
