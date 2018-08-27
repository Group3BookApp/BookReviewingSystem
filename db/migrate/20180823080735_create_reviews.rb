class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :num_rate
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:book_id, :created_at]
    add_index :reviews, [:user_id, :created_at]
  end
end
