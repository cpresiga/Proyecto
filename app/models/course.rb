class Course < ApplicationRecord
    has_many :topics, dependent: :destroy
    has_one_attached :course_logo
    validates :name, presence: true
    validates :description, presence: true
    validates :short_description, presence: true
    validates :level, presence: true
    validates :category, presence: true
    validates :video_url, presence: true
    validates :hours, presence: true
    validates :teacher_name, presence: true
    validates :teacher_description, presence: true

end
