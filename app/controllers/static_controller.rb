class StaticController < ApplicationController
  def index
    @top_projects = Project.order(:score).limit(3)
    @top_users = User.order(:score).limit(10)

  end
end
