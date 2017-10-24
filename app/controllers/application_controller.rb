class ApplicationController < ActionController::API
    include Knock::Authenticable, Petergate::ActionController::Base, ActionController::Helpers
  
    before_action :parse_params

    private

        def parse_params
            @offset = params[:offset].presence.try(&:to_i) || 0
            @limit = params[:limit].presence.try(&:to_i) || 25
        end

end
