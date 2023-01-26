class FeedbacksController < ApplicationController
  before_action :find_participacao, only: [:new, :create]
  before_action :find_feedback, only: [:aprovar]

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = @participacao.feedbacks.build(create_params)
    @feedback.autor = current_usuario

    flash.now[:confetti] = true

    if @feedback.save
      render turbo_stream: [
        turbo_stream.update("feedback-form", partial: "participacoes/new_feedback_btn", locals: {
          participacao: @participacao
        }),
        turbo_stream.prepend("feedbacks", @feedback)
      ]
    else
      render :new
    end
  end

  def aprovar
    @feedback.update(aprovar_params.merge(aprovado: true))
    flash.now[:confetti] = true
    render turbo_stream: turbo_stream.replace(@feedback)
  end

  private

  def find_participacao
    @participacao = Participacao.find(params[:participacao_id])
  end

  def create_params
    params.require(:feedback).permit(
      :mensagem,
      :responsabilidade,
      :comprometimento,
      :produtividade,
      :atendimento_humanizado,
    )
  end

  def aprovar_params
    params.require(:feedback).permit(:formato, :comentario_do_participante)
  end

  def find_feedback
    @feedback = Feedback.find(params[:id])
  end
end
