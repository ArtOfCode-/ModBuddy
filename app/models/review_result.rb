class ReviewResult < ApplicationRecord
  belongs_to :review_result_type
  belongs_to :offense_type
  belongs_to :sede_query
end
