json.books do
  json.array! @books do |b|
    json.id b.id
    json.title b.title
    json.author book_author b
    json.category book_category b
    json.comment_num book_comment_num b
    json.status Book.statuses[b.status]
    json.status_i18n b.status_i18n
  end
end
json.total @total
json.left_count @left_count
