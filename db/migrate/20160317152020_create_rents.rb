class CreateRents < ActiveRecord::Migration
  def change
    create_table :rents do |t|
      t.integer :book_id
      t.integer :user_id
      t.date :start_at, null: false
      t.date :end_at, null: false   # 返却予定の日
      t.date :ended_at, null: false # 返却した日
      t.timestamps null: false
    end
  end
end
