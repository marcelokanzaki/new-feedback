class HomeController < ApplicationController
  def show
    @ciclo = Ciclo.last
    @equipes = @ciclo.equipes
    render "ciclos/show"
  end
end
