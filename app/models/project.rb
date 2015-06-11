class Project < ActiveRecord::Base
  belongs_to :organisation
  has_and_belongs_to_many :users
  before_save :calc_score

  def duration
    #should be prettier
    TimeDifference.between(date_from, date_to).in_hours
  end

  def calc_score
    #stub
    self.score = 10
  end

end
