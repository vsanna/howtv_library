class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :request_type
      t.text :body, null:false
      t.integer :user_id, null:false
      t.timestamps null: false
    end
  end
end
