class CreateCommentsControllers < ActiveRecord::Migration
  def change
    create_table :comments_controllers do |t|
      t.string :create
      t.string :destroy

      t.timestamps null: false
    end
  end
end
