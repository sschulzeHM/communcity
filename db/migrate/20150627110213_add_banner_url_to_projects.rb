class AddBannerUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :banner_url, :string, default: "banners/banner_default.jpg"
  end
end
