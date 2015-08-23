class CollaboratorsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    wiki = Wiki.find(params[:wiki_id])
    collaborator = Collaborator.new(wiki: wiki, user: user)
    # authorize @collaborator

    if collaborator.save
      flash[:notice] = "#{user.name} was added as a collaborator to '#{wiki.title}'"
    else
      flash[:error] = "There was an error adding the collaborator. Please try again."
    end
    redirect_to edit_wiki_path wiki

    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def destroy
    user = User.find(params[:user_id])
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.where(user: user).first
    if collaborator.destroy
      flash[:notice] = "Removed a collaborator for '#{wiki.title}'"
    else
      flash[:error] = "There was an error removing the collaborator. Please try again."
    end
    redirect_to edit_wiki_path wiki

    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

end
