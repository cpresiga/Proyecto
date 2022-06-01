class AddFrameToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :video_url, :string
    add_column :topics, :topic_notes, :text
    add_column :topics, :about_topic, :string
    add_column :topics, :labels, :string
  end
end
