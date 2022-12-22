class EquipesController < ApplicationController
  before_action :find_ciclo, only: [:show]
  before_action :find_equipe, only: [:show]

  def show
  end

  private

  def find_ciclo
    @ciclo = Ciclo.find(params[:ciclo_id])
  end

  def find_equipe
    @equipe = Equipe.find(params[:id])
  end
end
