module ApplicationHelper

    # def saludo(user)
    #     "Hola" + user.full_name + " tu eres de " + user.from
    # end

    def avatar_url(user)
        if user.avatar.attached?
            url_for(user.avatar)
        elsif user.image?
            user.image
        else
       ActionController::Base.helpers.asset_path('icon_default_avatar.png')
        end
    end
end
