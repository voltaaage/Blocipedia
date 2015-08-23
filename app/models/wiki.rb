class Wiki < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  # Scope
  scope :visible_to, -> (user) { (user.role == 'premium' || user.role == 'admin') ? all : where(private: false) }
  
  #Need to define two scopes: users that are already collaborators and users that aren't
  #scope :non_collaborators, -> (user) { self.no_existing_collaboration(user.id,self.id) }

  # Delegates
  delegate :users, to: :collaborators

  def collaboration_exists?(user)
    self.collaborators.where(user: user).first
  end

  def can_modify_wiki?(user)
    self.collaboration_exists?(user) || user.role == 'admin'
  end

  def private?
    self.private
  end

  def public?
    !self.private
  end
end
