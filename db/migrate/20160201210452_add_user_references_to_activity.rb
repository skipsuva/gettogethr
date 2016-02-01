class AddUserReferencesToActivity < ActiveRecord::Migration
  def change
    change_table :activities do |t|
      t.references :user, index: true, foreign_key: true
    end
  end
end
