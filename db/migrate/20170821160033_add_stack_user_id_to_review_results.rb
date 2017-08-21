class AddStackUserIdToReviewResults < ActiveRecord::Migration[5.1]
  def change
    add_column :review_results, :stack_user_id, :integer
  end
end
