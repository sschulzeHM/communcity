class RenameUsersIdToUserId < ActiveRecord::Migration
  def change
    rename_column :projects_users, :users_id, :user_id
  end
end
