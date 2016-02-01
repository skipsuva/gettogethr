class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :gathering, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
