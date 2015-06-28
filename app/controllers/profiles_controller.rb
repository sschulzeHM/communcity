class ProfilesController < ApplicationController
  #since devise does not come with show actions for its models... we have to create our own show views
  #obsolete now, created seperate controllers with their individual show methods, for more resourceful routing
  def show_user
    @user = User.find(params[:id])
  end

  def show_organisation
    @organisation = Organisation.find(params[:id])
  end
end
