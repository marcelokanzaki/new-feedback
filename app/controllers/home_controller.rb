class HomeController < ApplicationController
  def show
    @ciclo = Ciclo.last

    @equipes = case params[:view]
    when "minha-equipe" then @ciclo.equipes.joins(:participacoes).where(participacoes: { participante_id: current_usuario.id })
    when "hierarquia" then @ciclo.equipes.where(equipes: { avaliador_id: current_usuario.id }).take.try(:hierarquia) || []
    else
      if params[:q].present?
        @ciclo.equipes
          .joins(participacoes: :participante)
          .where("lower(equipes.nome) like :q OR lower(usuarios.nome) like :q", q: "%#{params[:q].downcase}%")
          .group("equipes.id")
      else
        @ciclo.equipes
      end
    end
    render "ciclos/show"
  end
end
