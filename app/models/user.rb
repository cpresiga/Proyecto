class User < ApplicationRecord
    has_many :articles
    has_secure_password
    has_one_attached :avatar

    validates :name, presence: true
    validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Incorrect email format" }
    validates :password, presence: true
    validates :password, length: {minimum: 8 }
end
