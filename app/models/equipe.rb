class Equipe < ApplicationRecord
  belongs_to :ciclo
  belongs_to :avaliador, class_name: "Usuario", required: false
  belongs_to :padrinho, class_name: "Usuario", optional: true
  has_many :participacoes, -> { order(created_at: :asc) }, class_name: "Participacao", dependent: :destroy
  has_many :participantes, through: :participacoes, source: :participante

  validates_presence_of :nome

  def conclusao
    (participacoes.concluida.count / participacoes.count) * 100
  rescue
    nil
  end
end

# == Schema Information
#
# Table name: equipes
#
#  id           :integer          not null, primary key
#  ciclo_id     :integer          not null
#  nome         :string           default(""), not null
#  avaliador_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  padrinho_id  :integer
#  concluida    :boolean          default(FALSE), not null
#
