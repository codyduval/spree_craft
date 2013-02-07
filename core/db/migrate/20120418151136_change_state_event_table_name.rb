class ChangeStateEventTableName < ActiveRecord::Migration
  def change
    rename_table :state_events, :state_change_logs
  end 
end
