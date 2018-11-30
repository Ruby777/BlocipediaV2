class CollaboratorsController < ApplicationController
    def index
        @collaborators = Collaborator.all
        @wiki = Wiki.find(params[:wiki_id])
    end

    def new
        @wiki = Wiki.find(params[:wiki_id])
        @collaborator = Collaborator.new
    end
    def create
        @wiki = Wiki.find(params[:collaborator][:wiki_id])
        @users = User.find(params[:collaborator][:user_id])
        @collaborator = @wiki.collaborators.new(user_id: params[:collaborator][:user_id])
       
        if @collaborator.save
            flash[:notice] = "The collaborator has been added."
            redirect_to wikis_path
        else
            flash[:alert] = "There was an error while adding the collaborator. Please try again."
            render :show
        end
    end

    def destroy
        @collaborator = Collaborator.find(params[:id])

        if @collaborator.destroy
            flash[:notice] = "Collaborator has been removed." 
        else
            flash.now[:alert] = "There was an error while removing the Collaborator."
        end

        redirect_to wikis_path
    end
end
