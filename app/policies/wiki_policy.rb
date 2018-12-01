class WikiPolicy < ApplicationPolicy

    class Scope < Scope
        attr_reader :user, :scope

        def initialize(user, scope)
            @user = user
            @scope = scope
        end

        def resolve
            wikis = []

            #if the user is an admin, show them all the wikis
            if user.role == 'admin'
                wikis = scope.all 
            elsif user.role == 'premium'
                all_wikis = scope.all
                all_wikis.each do |wiki|
                    #if the user is premium, only show them public wikis, or that private wikis
                    #they created, or private wikis they are a collaborator on
                    if wiki.private.nil? || wiki.user == user  || wiki.collaborators.pluck(:user_id).include?(user.id)
                        wikis << wiki
                    end
                end
            else # for the standard user
                all_wikis = scope.all
                wikis = []
                all_wikis.each do |wiki|
                    if wiki.private.nil?  || wiki.collaborators.pluck(:user_id).include?(user.id)
                        wikis << wiki
                    end
                end
            end
            wikis #return the wikis array we've built up
        end
    end
end