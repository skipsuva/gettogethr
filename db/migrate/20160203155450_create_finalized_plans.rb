class CreateFinalizedPlans < ActiveRecord::Migration
  def change
    create_table :finalized_plans do |t|
      t.references :gathering, index: {:unique=>true}, foreign_key: true
      t.references :moment, index: {:unique=>true}, foreign_key: true
      t.references :place, index: {:unique=>true}, foreign_key: true
      t.references :activity, index: {:unique=>true}, foreign_key: true

      t.timestamps null: false
    end
  end
end
