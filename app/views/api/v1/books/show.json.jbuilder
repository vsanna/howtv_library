json.result do
  json.title = @book.title
  json.author = @book.author
  json.category = @book.category
  json.publisher = @book.publisher
  json.published_at = @book.published_at
  json.image = book_image(@book.hires_image, @book.large_image)
  json.description = @book.description
  json.url = @book.url
end
