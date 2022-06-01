json.extract! topic, :id, :title, :lessons_number, :evaluation_status, :course_id, :created_at, :updated_at
json.url topic_url(topic, format: :json)
