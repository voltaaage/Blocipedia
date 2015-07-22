class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(params.require(:wiki).permit(:title,:body))
    if @wiki.save
      flash[:notice] = "Wiki was sucessfully saved."
      redirect_to @wiki
    else
      flash[:error] = "THere was an error saving the wiki."
      render :new
    end
  end

  def edit
  end

  def destroy
  end
end
