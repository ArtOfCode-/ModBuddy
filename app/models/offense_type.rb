class OffenseType < ApplicationRecord
  has_many :sede_queries

  validates :name, uniqueness: true
end
