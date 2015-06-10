class CreateOrganisationsProjects < ActiveRecord::Migration
  def change
    create_table :organisations_projects, :id => false do |t|
      t.references :organisation
      t.references :project
    end
  end
end
