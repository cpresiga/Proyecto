class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :lessons_number
      t.string :evaluation_status
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
