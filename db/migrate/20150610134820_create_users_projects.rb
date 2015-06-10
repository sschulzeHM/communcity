class CreateUsersProjects < ActiveRecord::Migration
  def change
    create_table :users_projects, :id => false do |t|
      t.references :users
      t.references :project
    end
  end
end
