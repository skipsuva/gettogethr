class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.user :references, index: true, foreign_key: true
      t.gathering :references, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
