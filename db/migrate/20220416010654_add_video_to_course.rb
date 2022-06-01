class AddVideoToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :video_url, :string
    add_column :courses, :hours, :integer
    add_column :courses, :category, :string
  end
end
