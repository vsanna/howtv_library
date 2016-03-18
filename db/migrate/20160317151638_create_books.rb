class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :isbn10
      t.text :isbn13
      t.string :title
      t.string :author
      t.date :published_at
      t.string :publisher
      t.integer :status, null: false, default: 0
      t.string :hires_image
      t.string :large_image
      t.text :description
      t.text :url
      t.string :category
      t.timestamps null: false
    end
  end
end
