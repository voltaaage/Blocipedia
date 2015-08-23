class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Associations
  has_many :collaborators
  has_many :wikis, through: :collaborators

  # Delegates
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

  private

  def default_role
    self.role ||= 'standard' # if role is false/empty then set it to 'standard'
  end

end
