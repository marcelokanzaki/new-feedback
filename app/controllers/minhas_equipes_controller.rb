class MinhasEquipesController < ActionController
  def show
    @equipes = Equipe.find_by(avaliador: current_usuario)&.hierarquia || []
  end
end
