class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :location
      t.date :date_from
      t.date :date_to
      t.integer :score, default: 0, null: false
      t.text :description
      t.string :category
      t.float :longitude
      t.float :latitude
      t.integer :organisation_id

      t.timestamps null: false
    end
  end
end
