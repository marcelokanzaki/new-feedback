class ApplicationController < ActionController::Base
  before_action :authenticate_usuario!
  impersonates :user, method: :current_usuario, with: -> id { Usuario.find_by(id: id) }
end
