class FeedbacksController < ApplicationController
  before_action :find_participacao, only: [:new]
  before_action :find_feedback, only: [:aprovar]

  def new
    @feedback = Feedback.new
  end

  def create

  end

  def aprovar
    @feedback.update(params.require(:feedback).permit(:comentario_do_participante))
  end

  private

  def find_participacao
    @participacao = Participacao.find(params[:participacao_id])
  end

  def find_feedback
    @feedback = Feedback.find(params[:id])
  end
end
