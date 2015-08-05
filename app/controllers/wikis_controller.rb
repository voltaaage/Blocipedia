class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
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
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_attributes)
      flash[:notice] = "Wiki was succesfully updated"
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
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
