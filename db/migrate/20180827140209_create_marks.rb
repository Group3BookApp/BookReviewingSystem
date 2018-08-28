class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :status
      t.string :favorite

      t.timestamps
    end
  end
end
