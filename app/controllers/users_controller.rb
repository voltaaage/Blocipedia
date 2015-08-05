class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

  def upgrade
    @user = User.find(params[:user_id])
    @user.update(role: 'premium')
    # @user.save
    redirect_to root_path
  end

  def downgrade
    @user = User.find(params[:user_id])
    @user.update(role: 'standard')
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :role)
  end
end
