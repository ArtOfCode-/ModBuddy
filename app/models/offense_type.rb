class OffenseType < ApplicationRecord
  has_many :sede_queries
  has_many :review_results

  validates :name, uniqueness: true
end
