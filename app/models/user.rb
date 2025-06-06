# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recommendations, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :books, through: :recommendations # Optional: to see books recommended by user
end