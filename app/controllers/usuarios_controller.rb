class UsuariosController < ApplicationController
  def impersonate
    user = Usuario.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end
end
