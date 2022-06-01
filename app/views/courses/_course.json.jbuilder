json.extract! course, :id, :name, :description, :level, :evaluation_status, :course_score, :created_at, :updated_at
json.url course_url(course, format: :json)
