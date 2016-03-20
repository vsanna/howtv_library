module RentsHelper
  def calc_rent_days rent
    gap = (rent.end_at - Date.today).to_i
    if gap > 0
      "#{gap}日後"
    elsif gap == 0
      "今日返却日です"
    else
      "#{gap}日過ぎています"
    end
  end
end
