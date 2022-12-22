class CiclosController < ApplicationController
  def show
    @ciclo = Ciclo.find(params[:id])
  end
end
