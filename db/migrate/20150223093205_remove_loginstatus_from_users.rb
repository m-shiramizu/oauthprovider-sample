class RemoveLoginstatusFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :loginstatus, :boolean
  end
end
