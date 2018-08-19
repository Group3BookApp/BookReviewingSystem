class CreateBookMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :book_marks do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :status
      t.integer :favorite

      t.timestamps
    end
  end
end
