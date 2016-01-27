class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :gathering, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
