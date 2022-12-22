class MeusFeedbacksController < ApplicationController
  def show
    @feedbacks = Feedback.limit(10)
      # .joins(:participacao)
      # .where(participacoes: { participante: current_usuario })
  end
end
