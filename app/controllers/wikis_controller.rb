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
    else
      flash[:error] = "THere was an error saving the wiki."
    end
      redirect_to edit_wiki_path @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
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
    redirect_to edit_wiki_path @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    
    if @wiki.destroy
      flash[:notice] = "\" #{@wiki.title}\" was succesfully destroyed."
    else
      flash[:error] = "There was an error deleting the wiki. Please try agian."
    end
    redirect_to wikis_path
  end

  private

  def wiki_attributes
    params.require(:wiki).permit(:title,:body,:private)
  end
end
