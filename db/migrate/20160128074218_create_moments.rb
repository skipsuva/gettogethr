class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.datetime :time
      t.references :gathering, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
