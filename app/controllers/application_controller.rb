class ApplicationController < ActionController::Base
  include ActionView::RecordIdentifier
  before_action :authenticate_usuario!
  impersonates :user, method: :current_usuario, with: -> id { Usuario.find_by(id: id) }
end
