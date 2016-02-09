class AddNotifiedToInterests < ActiveRecord::Migration
  def change
    change_table :interests do |t|
      t.datetime :notified_at
    end
  end
end
