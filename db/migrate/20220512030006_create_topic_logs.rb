class CreateTopicLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :topic_logs do |t|
      t.integer :course_id
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
