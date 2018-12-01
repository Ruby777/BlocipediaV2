class CollaboratorsController < ApplicationController

    def create
        @wiki = Wiki.find(params[:wiki_id])
        @user = User.find_by_email(params[:collaborator][:user])

        if User.exists?(@user.id)
            @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)
            
            if @collaborator.save
                flash[:notice] = "Collaborator Added"
            else
                flash[:error] = "There seems to be a problem. Please try again."
            end
            redirect_to @wiki
        else
            flash[:error] = "There is no such user"
            redirect_to @wiki
        end
    end

    def destroy
        @wiki = Wiki.find(params[:wiki_id])
        @collaborator = Collaborator.find(params[:id])

        if @collaborator.destroy
            flash[:notice] = "You have removed the Collaborator successfully"
            redirect_to @wiki
        else
            flash.now[:alert] = "There was an error deleting the Colaborator"
            redirect_to @wiki
        end
    end
end
