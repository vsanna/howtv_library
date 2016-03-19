module BooksHelper
  def book_image book
    if book.hires_image
      book.hires_image
    elsif book.large_image
      book.large_image
    else
      nil
    end
  end

  def book_author book
    if book.author.nil?
      if book.publisher.nil?
        '著者不明'
      else
        book.publisher
      end
    else
      book.author
    end
  end

  def book_category book
    book.category.nil? ? 'カテゴリ不明' : book.category
  end

  def book_comment_num book
    if book.comments.count == 0
      'コメント無し><'
    else
      book.comments.count.to_s + "件のコメント"
    end
  end
end
