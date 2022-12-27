class NotasController < ApplicationController
  def update
    @nota = Nota.find(params[:id])
    @nota.update(nota_params)
    head :ok
  end

  private

  def nota_params
    params.require(:nota).permit(:texto)
  end
end
