class CollaboratorsController < ApplicationController
    def create
        @collaborator = Collaborator.new
        @wiki = Wiki.find_by(id: params[:collaborator][:wiki_id])
       
        if @collaborator.save
            flash[:notice] = "The collaborator has been added."
            redirect_to :index
        else
            flash[:alert] = "There was an error while adding the collaborator. Please try again."
            render :show
        end
    end

    def destroy
        @wiki = Wiki.find(params[:wiki_id])
        @collaborator = Collaborator.find(params[:id])

        if @collaborator.destroy
            flash[:notice] = "Collaborator has been removed." 
        else
            flash.now[:alert] = "There was an error while removing the Collaborator."
        end

        redirect_to @wiki
    end
end
