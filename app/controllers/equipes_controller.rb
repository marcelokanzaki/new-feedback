class EquipesController < ApplicationController
  before_action :find_ciclo, only: [:new, :create]
  before_action :find_equipe, only: [:show, :edit, :update, :destroy]

  def new
    if params[:cancelar]
      render turbo_stream: turbo_stream.update("nova-equipe", "")
    else
      @equipe = @ciclo.equipes.new
    end
  end

  def create
    @equipe = @ciclo.equipes.new(equipe_params)

    if @equipe.save
      redirect_to ciclo_url(@ciclo), status: 303
    else
      render :new
    end
  end

  def show
  end

  def edit
    if params[:cancelar]
      render turbo_stream: turbo_stream.replace(@equipe)
    end
  end

  def update
    if @equipe.update(equipe_params)
      render turbo_stream: turbo_stream.replace(@equipe)
    else
      render :edit
    end
  end

  def destroy
    @equipe.destroy
    render turbo_stream: turbo_stream.remove(@equipe)
  end

  private

  def find_ciclo
    @ciclo = Ciclo.find(params[:ciclo_id])
  end

  def equipe_params
    params.require(:equipe).permit(:nome, :avaliador_id, :padrinho_id)
  end

  def find_equipe
    @equipe = Equipe.find(params[:id])
  end
end
