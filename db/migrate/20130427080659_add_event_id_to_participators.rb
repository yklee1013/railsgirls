class AddEventIdToParticipators < ActiveRecord::Migration
  def change
    add_column :participators, :event_id, :integer
    add_index :participators, :event_id
  end
end
