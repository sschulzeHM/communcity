class Project < ActiveRecord::Base
  belongs_to :organisation
  has_and_belongs_to_many :users
  before_save :calc_score

  STATE = {UPCOMING: "Upcoming", IN_PROGRESS: "In Progress", OVER: "Over", DONE: "Done"}

  def self.by_date
    Project.all.order(date_from: :desc)
  end

  def duration
    #should be prettier
    TimeDifference.between(date_from, date_to).in_hours
  end

  def calc_score
    #initial score depending on project duration
    self.score= duration*10
    #bonus depending on number of users
    self.score += users.size*10
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
    not has_user?(user) and has_room? and not (done or state === STATE[:OVER])
  end

end
