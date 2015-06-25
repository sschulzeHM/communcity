class StaticController < ApplicationController
  def index
    @top_projects = Project.order(score: :desc).limit(3)
    @top_users = User.order(score: :desc).limit(10)

  end
end
