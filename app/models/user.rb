class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :projects

  validates :first_name, presence: true, length: {in: 3..15}
  validates :last_name, presence: true, length: {in: 3..20}
  validates :location, presence: true


  def done_projects
    projects.done
  end

  def current_projects
    projects.select{ |p| p.has_state? Project::STATE[:UPCOMING] or p.has_state? Project::STATE[:IN_PROGRESS]}
  end
end
