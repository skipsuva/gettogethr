class RemoveUniquenessConstraintsForFinalizedPlan < ActiveRecord::Migration
  def change
    remove_index :finalized_plans, :gathering_id
    remove_index :finalized_plans, :moment_id
    remove_index :finalized_plans, :place_id
    remove_index :finalized_plans, :activity_id
    add_index :finalized_plans, :gathering_id
    add_index :finalized_plans, :moment_id
    add_index :finalized_plans, :place_id
    add_index :finalized_plans, :activity_id
  end
end
