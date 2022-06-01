class Topic < ApplicationRecord
  has_many :challenges, dependent: :destroy
  belongs_to :course
  has_rich_text :topic_notes
end
