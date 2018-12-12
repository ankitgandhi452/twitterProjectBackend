class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
        before_action :authenticate_user!, unless: :devise_controller

        def devise_controller
                ['devise_token_auth', 'api'].include?(params[:controller].split('/')[0])
        end
end
