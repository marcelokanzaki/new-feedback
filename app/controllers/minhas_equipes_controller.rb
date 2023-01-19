class MinhasEquipesController < ApplicationController
  def show
    @equipes = Equipe.find_by(avaliador: current_usuario)&.hierarquia || []
  end
end
