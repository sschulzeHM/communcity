class ChangeLongLatColumnTypes < ActiveRecord::Migration
  def up
    change_column :organisations, :longitude, :float
    change_column :organisations, :latitude, :float
    # change_column :users, :longitude, :float
    # change_column :users, :latitude, :float
  end

  def down
    change_column :organisations, :longitude, :integer
    change_column :organisations, :latitude, :integer
    # change_column :users, :longitude, :integer
    # change_column :users, :latitude, :integer
  end
end
