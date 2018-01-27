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
    @users = User.all
  end

  def update
    @wiki = Wiki.find(params[:id])

    authorize @wiki

    @wiki.assign_attributes(wiki_params)

    if params[:collaborator_ids]
      params[:collaborator_ids].each do |c|
        @wiki.collaborators << Collaborator.create(wiki_id: @wiki.id, user_id: c)
      end
    end


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
