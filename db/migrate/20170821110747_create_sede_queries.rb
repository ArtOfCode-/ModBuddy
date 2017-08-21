class CreateSedeQueries < ActiveRecord::Migration[5.1]
  def change
    create_table :sede_queries do |t|
      t.string :url
      t.references :offense_type, foreign_key: true
      t.datetime :last_fetch

      t.timestamps
    end
  end
end
