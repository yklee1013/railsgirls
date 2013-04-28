class UpdateStartsAtToEvents < ActiveRecord::Migration
  def change
    change_column :events, :starts_at, :date
  end
end
