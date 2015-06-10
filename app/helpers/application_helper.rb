module ApplicationHelper

  #well... wanted to make a helper :P
  def concat_username(user)
    "#{user.first_name} #{user.last_name}"
  end

  #checks wether any user role is signed in... should come in handy sometimes I guess
  def signed_in?
    user_signed_in? or organisation_signed_in?
  end
end
