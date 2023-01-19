class MeusFeedbacksController < ApplicationController
  def show
    @feedbacks = Feedback
      .joins(:participacao)
      .where(participacoes: { participante: current_usuario })
      .order(created_at: :desc)
  end
end
