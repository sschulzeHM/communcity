class AddMaxUsersToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :max_users, :integer, null: false, default: 1
  end
end
