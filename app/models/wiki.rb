class Wiki < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  # Scope
  scope :visible_to, -> (user) { (user.role == 'premium' || user.role == 'admin') ? all : where(private: false) }
  
  # Delegates
  delegate :users, to: :collaborators

  def collaborators
    Collaborator.where(wiki_id: id)
  end

  def private?
    self.private
  end

  def public?
    !self.private
  end
end
