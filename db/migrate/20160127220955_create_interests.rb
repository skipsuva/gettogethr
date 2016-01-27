class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.user :references
      t.gathering :references

      t.timestamps null: false
    end
  end
end
