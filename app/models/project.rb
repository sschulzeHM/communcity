class Project < ActiveRecord::Base
  belongs_to :organisation
  has_and_belongs_to_many :users
  before_save :calc_score
  #should probably be a config var
  BANNER_DIR = 'banners/'
  STATE = {UPCOMING: "Kommt bald", IN_PROGRESS: "Läuft", OVER: "Vorbei", DONE: "Abgeschlossen"}

  scope :done, -> { where(done: true)}


  def self.by_date
    Project.all.order(date_from: :desc)
  end

  def duration
    TimeDifference.between(date_from, date_to).in_hours
  end

  def calc_score
    #initial score depending on project duration
    self.score= duration*10
    #bonus depending on number of users
    self.score += users.size*10
  end

  #set status to done and add score to users
  def set_done
    ActiveRecord::Base.transaction do
      done = true
      users.each do |u|
        tmp_score = u.score || 0
        tmp_score+= score
        u.score = tmp_score
        #eh... should probably abort if a save fails...
        u.save
      end
      save
    end
  end

  def create_banner_url
    "#{BANNER_DIR}banner_#{organisation.id}_#{id}.jpg"
  end

  def has_user?(user)
    user.in? self.users
  end

  def has_current_user?
    has_user?(current_user)
  end

  def has_room?
    #should obviously compare to a cached value in reality
    users.size < max_users
  end

  def places_left
    max_users - users.size
  end

  def percentage_filled
    unless (max_users.nil? or max_users === 0) then
      ((users.size.to_f/max_users)*100)
    else
      0
    end
  end

  def state
    return STATE[:DONE] if done
    return STATE[:UPCOMING] if Time.now < date_from
    return STATE[:IN_PROGRESS] if Time.now < date_to
    return STATE[:OVER]
  end

  def has_state? state
    state === self.state
  end

  def joinable?(user)
    not has_user?(user) and has_room? and not (done or state === STATE[:OVER])
  end

end
