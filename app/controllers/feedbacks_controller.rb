class FeedbacksController < ApplicationController
  before_action :find_participacao, only: [:new]

  def new
    @avaliacao = Avaliacao.new
    @feedback = Feedback.new
  end

  private

  def find_participacao
    @participacao = Participacao.find(params[:participacao_id])
  end
end
