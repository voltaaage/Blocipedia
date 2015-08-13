class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Associations
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  # delegates
  delegate :wikis, to: :collaborators
  
  after_initialize :default_role

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def standard?
    role == 'standard'
  end

  def collaborators
    Collaborator.where(user_id: id)
  end

  private

  def default_role
    self.role ||= 'standard'
  end

end
