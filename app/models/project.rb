class Project < ActiveRecord::Base
  belongs_to :organisation
  has_and_belongs_to_many :users
  before_save :calc_score

  STATE = {UPCOMING: "Upcoming", IN_PROGRESS: "In Progress", OVER: "Over", DONE: "Done"}

  def duration
    #should be prettier
    TimeDifference.between(date_from, date_to).in_hours
  end

  def calc_score
    #stub
    self.score = 10
  end

  def has_user?(user)
    user.in? self.users
  end

  def has_current_user?
    has_user?(current_user)
  end

  def places_left
    max_users - users.size
  end

  def has_room?
    #should obviously compare to a cached value in reality
    users.size < max_users
  end

  def state
      return STATE[:DONE] if done
      return STATE[:UPCOMING ]if Time.now < date_from
      return STATE[:IN_PROGRESS ]if Time.now < date_to
      return STATE[:OVER]
  end

  def joinable?(user)
    not @project.has_user?(user) and @project.has_room? and not (over or complete)
  end

end
