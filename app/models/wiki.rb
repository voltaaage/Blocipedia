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

  def collaborators
    Collaborator.where(wiki_id: id)
  end

  def create_collaborators_from_array

  end

  def create_collaborator(users)
    # for each user selected from the form
    users.each do |user_to_add|
      # perform check on whether the relationship already exists
      puts self.id
      # if no_existing_collaboration?(user_to_add.id,self.id)
        collaborator = Collaborator.new(
          wiki_id: self.id,
          user_id: user_to_add.id
        )
        collaborator.save!
      # end
    end
    
  end

  def no_existing_collaboration?(user_id,wiki_id)
    !(Collaborator.where(user_id: user_id, wiki_id: wiki_id) == [])
  end

  def private?
    self.private
  end

  def public?
    !self.private
  end
end
