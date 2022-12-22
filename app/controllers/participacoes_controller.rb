class ParticipacoesController < ApplicationController
  before_action :find_ciclo, only: [:show]
  before_action :find_participacao, only: [:show]

  def show
    @feedbacks = Feedback
      .joins(:participacao)
      .where(participacoes: { participante: @participacao.participante })
      .order(created_at: :desc)
  end

  private

  def find_ciclo
    @ciclo = Ciclo.find(params[:ciclo_id])
  end

  def find_participacao
    @participacao = Participacao.find(params[:id])
  end
end
