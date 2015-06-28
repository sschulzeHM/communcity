class StaticController < ApplicationController
  def index
    @top_projects = Project.order(score: :desc).limit(9)
    @top_users = User.order(score: :desc).limit(10)

  end
end
