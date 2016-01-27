class CreateGatherings < ActiveRecord::Migration
  def change
    create_table :gatherings do |t|
      t.string :title
      t.owner :references

      t.timestamps null: false
    end
  end
end
