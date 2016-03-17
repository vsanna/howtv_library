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
      t.timestamps null: false
    end
  end
end
