# app/models/recommendation.rb
class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :votes, dependent: :destroy
  accepts_nested_attributes_for :book
  validates :review, presence: true, length: { maximum: 250 }

  def total_votes
    votes.count
  end

  def self.trending(days_ago = 7)
    where('recommendations.created_at >= ?', days_ago.days.ago)
      .left_joins(:votes)
      .group('recommendations.id')
      .order('COUNT(votes.id) DESC, recommendations.created_at DESC')
  end
end