class AddUserToReviewResults < ActiveRecord::Migration[5.1]
  def change
    add_reference :review_results, :user, foreign_key: true
  end
end
