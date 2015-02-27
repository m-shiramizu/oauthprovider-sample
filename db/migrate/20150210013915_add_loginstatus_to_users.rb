class AddLoginstatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :loginstatus, :boolean
  end
end
