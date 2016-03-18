json.result do
  json.book do
    json.title @book.title
    json.author @book.author
    json.category @book.category
    json.publisher @book.publisher
    json.published_at @book.published_at.strftime("%Y.%m") if @book.published_at
    json.image book_image(@book)
    json.description @book.description
    json.url @book.url
  end
  json.comments do
    json.array! @comments do |c|
      json.body c.body
      json.created_at c.created_at.strftime("%Y.%m.%d")
      json.user "#{c.user.family_name} #{c.user.given_name}氏"
    end
  end
end
