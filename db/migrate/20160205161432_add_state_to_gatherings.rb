class AddStateToGatherings < ActiveRecord::Migration
  def change
    change_table :gatherings do |t|
      t.string aasm_state
    end
  end
end
