class Ciclo < ApplicationRecord
  has_many :equipes, -> { order(nome: :asc) }, dependent: :destroy
  has_many :participacoes, through: :equipes
  has_many :feedbacks, -> { order(created_at: :desc) }, through: :participacoes

  enum status: { configurando: 0, em_andamento: 1, encerrado: 2 }

  validates_presence_of :nome

  scope :ordenado, -> { order(created_at: :desc) }
  scope :publico, -> { where(status: [1, 2]) }

  def totalDeFeedbacks
    quantidade_de_feedbacks
  end

  def equipe(participante)
    equipes
      .joins(:participantes)
      .where(usuarios: { id: participante.id }).take
  end
end

# == Schema Information
#
# Table name: ciclos
#
#  id                      :bigint           not null, primary key
#  fim                     :date
#  inicio                  :date
#  nome                    :string           default(""), not null
#  quantidade_de_feedbacks :integer          default(1), not null
#  status                  :integer          default("configurando"), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
