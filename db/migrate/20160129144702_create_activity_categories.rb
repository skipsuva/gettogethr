class CreateActivityCategories < ActiveRecord::Migration
  def change
    create_table :activity_categories do |t|
      t.string :label

      t.timestamps null: false
    end
  end
end
