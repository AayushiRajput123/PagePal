# app/models/book.rb
class Book < ApplicationRecord
  has_many :recommendations, dependent: :destroy
  validates :title, presence: true
  validates :author, presence: true
end