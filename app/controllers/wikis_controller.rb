class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaborations = Collaborator.where(wiki_id: @wiki)
    @collaborators = User.where(id: @collaborations.pluck(:user_id))
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_attributes)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was sucessfully saved."
      redirect_to @wiki
    else
      flash[:error] = "THere was an error saving the wiki."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collaborators = []
    @non_collaborators = []
    User.all.each do |user|
      collaborator_exists = Collaborator.exists?(user_id: user.id, wiki_id: @wiki.id)
      if collaborator_exists
          @collaborators << user unless @collaborators.include?(user)
      else
          @non_collaborators << user unless @non_collaborators.include?(user)
      end
    end

    # @collaborations = Collaborator.where(wiki_id: @wiki)
    # @collaborators = User.where(id: @collaborations.pluck(:user_id))
    # @non_collaborators = User.where()

    @users = User.all
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_attributes)
      flash[:notice] = "Wiki was succesfully updated"
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
    end
    render :edit
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\" #{@wiki.title}\" was succesfully destroyed."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki. Please try agian."
      render :show
    end
  end

  private

  def wiki_attributes
    params.require(:wiki).permit(:title,:body, :private)
  end
end
