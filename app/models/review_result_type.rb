class ReviewResultType < ApplicationRecord
  has_many :review_results

  validates :name, uniqueness: true
end
