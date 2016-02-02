class RenameTableTableUsersToUsers < ActiveRecord::Migration
  def change
    rename_table :table_users, :users
  end
end
