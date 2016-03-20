module RentsHelper
  def calc_rent_days rent
    gap = (rent.end_at - Date.today).to_i
    if gap > 0
      content_tag :span, "#{gap}日後", class:'before-due due-tag'
    elsif gap == 0
      content_tag :span, "今日返却日です", class:'on-the-due due-tag'
    else
      content_tag :span, "#{gap}日過ぎています", class:"after-due due-tag"
    end
  end
end
