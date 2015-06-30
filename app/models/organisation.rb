class Organisation < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  validates :name, presence: true, uniqueness: true, length: {in: 3..25} #erm good enough imho
  validates :location, presence: true

  before_save :calc_score

  private

  def calc_score
    #stub
    self.score = 10
  end
end
