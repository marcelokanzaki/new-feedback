class ParticipacoesController < ApplicationController
  before_action :find_equipe, only: [:new, :create]
  before_action :find_participacao, only: [:show]

  def new
    @candidatos = Usuario.ativo.where('nome @@ :full_text AND nome ilike :ilike', {
      full_text: params[:q],
      ilike: "%#{params[:q]}%"
    }).limit(30)
  end

  def create
    usuarios = Usuario.find(usuario_ids)

    usuarios.each do |usuario|
      Participacao.create(participante: usuario, equipe: @equipe)
    end

    render turbo_stream: turbo_stream.replace(@equipe)
  end

  def show
    @feedbacks = Feedback
      .joins(:participacao)
      .where(participacoes: { participante: @participacao.participante })
      .order(created_at: :desc)

    if current_usuario == @participacao.equipe&.avaliador
      @nota = Nota.find_or_create_by(
        participante: @participacao.participante,
        avaliador: @participacao.equipe.avaliador
      )
    end
  end

  private

  def usuario_ids
    params.permit(usuarios: [])[:usuarios] || []
  end

  def find_equipe
    @equipe = Equipe.find(params[:equipe_id])
  end

  def find_participacao
    @participacao = Participacao.find(params[:id])
  end
end
