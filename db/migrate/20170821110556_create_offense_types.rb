class CreateOffenseTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :offense_types do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
