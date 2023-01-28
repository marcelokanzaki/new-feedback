class CiclosController < ApplicationController
  before_action :find_ciclo, only: [:show, :edit, :update, :create, :destroy, :clonar]

  def new
    @ciclo = Ciclo.new
  end

  def create
    @ciclo = Ciclo.new(ciclo_params)

    if @ciclo.save
      redirect_to admin_ciclo_url(@ciclo)
    else
      render :new
    end
  end

  def show
    @equipes = case params[:view]
    when "minha-equipe" then @ciclo.equipes.joins(:participacoes).where(participacoes: { participante_id: current_usuario.id })
    when "hierarquia" then @ciclo.equipes.where(equipes: { avaliador_id: current_usuario.id }).take.try(:hierarquia) || []
    else
      if params[:q]
        @ciclo.equipes.where("lower(nome) like ?", "%#{params[:q].downcase}%")
      else
        @ciclo.equipes
      end
    end
  end

  def edit
  end

  def update
    if @ciclo.update(ciclo_params)
      redirect_to ciclo_url(@ciclo)
    else
      render :edit
    end
  end

  def destroy
    if @ciclo.equipes.any?
    else
      @ciclo.destroy
      redirect_to root_url
    end
  end

  def clonar
    _clone = @ciclo.deep_clone include: { equipes: :participacoes }
    _clone.nome << " clone"
    _clone.status = :configurando

    _clone.equipes.each do |equipe|
      equipe.participacoes.each do |participacao|
        participacao.agencia = participacao.participante.agencia
        participacao.concluida = false
        participacao.com_copia = false
      end
    end

    _clone.save

    redirect_to _clone
  end

  private

  def ciclo_params
    params.require(:ciclo).permit(
      :nome,
      :quantidade_de_feedbacks,
      :status,
      :inicio,
      :fim
    )
  end

  def find_ciclo
    @ciclo = Ciclo.find(params[:id])
  end
end
