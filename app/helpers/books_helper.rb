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
end
