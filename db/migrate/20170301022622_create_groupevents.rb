class CreateGroupevents < ActiveRecord::Migration[5.0]
  def change
    create_table :groupevents do |t|
      t.string :name
      t.text :description
      t.string :location
      t.date :start_date
      t.date :end_date
      t.integer :duration
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
