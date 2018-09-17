class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def downgrade
        current_user.role = 'standard'
        current_user.save

        current_user.wikis.where(private: true).update_all(private: nil)

        flash[:notice] = "#{current_user.email} you have successfully changed your membership to #{current_user.role} member!"
        redirect_to root_path
    end
end
