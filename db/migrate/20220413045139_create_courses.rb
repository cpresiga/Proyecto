class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.integer :level
      t.string :evaluation_status
      t.float :course_score
      t.timestamps
    end
  end
end
