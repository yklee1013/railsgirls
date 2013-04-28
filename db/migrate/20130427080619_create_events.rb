class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :city
      t.string :map
      t.datetime :starts_at
      t.string :summary
      t.text :body

      t.timestamps
    end
  end
end
