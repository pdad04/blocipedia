class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.where.not(id: current_user.id)
  end

  def update
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    @wiki.assign_attributes(wiki_params)

    # Only check if collaborators are added/removed when Wiki owner performs edit.
    if @wiki.user_id == current_user.id
      User.all.each do |u|
        if params[:wiki][:collaborator_ids] && params[:wiki][:collaborator_ids].include?(u.id.to_s)
          @wiki.users << u
        else
          @wiki.users.delete(u)
        end
      end

      # Private wiki unchecked should clear collaborators
      # Since wiki will be public all users will have access anyways.
      if params[:wiki][:private] == "0"
        @wiki.users.clear
      end
    end

    # # Add collaborators access to users which were selected
    # if params[:wiki][:collaborator_ids]
    #   params[:wiki][:collaborator_ids].each do |c|
    #     @wiki.users << User.find(c.to_i)
    #   end
    # end


    if @wiki.save
      flash[:notice] = "Wiki was updated"
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving the Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
    else
      flash[:alert] = "There was an error deleting the post."
    end

    redirect_to wikis_path
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
