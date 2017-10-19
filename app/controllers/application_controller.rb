class ApplicationController < ActionController::API
  include Knock::Authenticable, Petergate::ActionController::Base, ActionController::Helpers
end
