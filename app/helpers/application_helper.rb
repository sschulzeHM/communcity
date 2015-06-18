module ApplicationHelper

  #well... wanted to make a helper :P
  def concat_username(user)
    "#{user.first_name} #{user.last_name}"
  end

  def remaining_places_text(project)
    "(Noch #{project.places_left} Plätze frei)" if project.has_room?

  end

  #checks wether any user role is signed in... should come in handy sometimes I guess
  def signed_in?
    user_signed_in? or organisation_signed_in?
  end

  def state_label_class state
    case state
      when Project::STATE[:DONE] then
        "label label-success"
      when Project::STATE[:UPCOMING ]then
        "label label-info"
      when Project::STATE[:IN_PROGRESS ]then
        "label label-warning"
      when Project::STATE[:OVER ]then
        "label label-danger"
      end
  end

  end