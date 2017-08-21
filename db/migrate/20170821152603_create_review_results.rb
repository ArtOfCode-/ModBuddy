class CreateReviewResults < ActiveRecord::Migration[5.1]
  def change
    create_table :review_results do |t|
      t.references :review_result_type, foreign_key: true
      t.references :offense_type, foreign_key: true
      t.references :sede_query, foreign_key: true

      t.timestamps
    end
  end
end
