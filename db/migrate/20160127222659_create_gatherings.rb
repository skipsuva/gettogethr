class CreateGatherings < ActiveRecord::Migration
  def change
    create_table :gatherings do |t|
      t.string :title
      t.references :owner, index: true

      t.timestamps null: false
    end
    add_foreign_key :gatherings, :users, column: :owner_id
  end
end
