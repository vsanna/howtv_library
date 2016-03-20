class Rent < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  def returned!
    self.ended_at = Date.today
    self.save
  end
end
