class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { (user.role == 'premium' || user.role == 'admin') ? all : where(private: false) }
 
  delegate :users, to: :collaborators

  def collaboration_exists?(user)
    self.users.include?(user)
  end

  def can_modify_wiki?(user)
    self.collaboration_exists?(user) || user.role == 'admin'
  end
end
