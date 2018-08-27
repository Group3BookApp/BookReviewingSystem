class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :num_page
      t.float :avg_rate
      t.text :description
      t.string :picture
      t.references :author, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
