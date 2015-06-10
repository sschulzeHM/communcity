class ProfilesController < ApplicationController
  #since devise does not come with show actions for its models... we have to create our own show views
  def show_user
    @user = User.find(params[:id])
  end

  def show_organisation
    @organisation = Organisation.find(params[:id])
  end
end
