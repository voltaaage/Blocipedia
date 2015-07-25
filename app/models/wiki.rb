class Wiki < ActiveRecord::Base
  belongs_to :user

  def private?
    self.private
  end
end
