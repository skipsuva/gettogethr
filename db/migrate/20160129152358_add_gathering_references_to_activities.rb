class AddGatheringReferencesToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :gathering, index: true, foreign_key: true
  end
end
