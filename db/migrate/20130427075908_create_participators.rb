class CreateParticipators < ActiveRecord::Migration
  def change
    create_table :participators do |t|
      t.string :email
      t.string :name
      t.string :type
      t.boolean :attended

      t.timestamps
    end
    add_index :participators, :email
    add_index :participators, :type
  end
end
