class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :room, null: false, foreign_key: true
      t.text :content, null: false
      t.timestamps

      t.index [:room_id, :created_at]
    end
  end
end
