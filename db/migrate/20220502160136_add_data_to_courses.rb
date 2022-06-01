class AddDataToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :short_description, :string
    add_column :courses, :teacher_name, :string
    add_column :courses, :teacher_description, :string
    add_column :courses, :labels, :string
  end
end
