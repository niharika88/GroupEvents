class ChangeColumnInTable < ActiveRecord::Migration[5.0]
  def change
  change_column :groupevents, :status, :integer, :default => 0
  end
end
