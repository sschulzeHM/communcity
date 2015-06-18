class AddDoneToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :done, :boolean, null: false, default: false
  end
end
