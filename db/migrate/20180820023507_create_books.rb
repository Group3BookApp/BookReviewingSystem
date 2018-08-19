class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.references :author, foreign_key: true
      t.references :categorie, foreign_key: true
      t.string :title
      t.integer :num_page
      t.integer :avg_rate
      t.text :description

      t.timestamps
    end
  end
end
