class Equipe < ApplicationRecord
  belongs_to :ciclo
  belongs_to :avaliador, class_name: "Usuario", required: false
  belongs_to :padrinho, class_name: "Usuario", optional: true
  has_many :participacoes, -> { order(created_at: :asc) }, class_name: "Participacao", dependent: :destroy
  has_many :participantes, through: :participacoes, source: :participante

  validates_presence_of :nome

  scope :concluida, -> { where(concluida: true) }

  def hierarquia
    children = Equipe.where(ciclo_id: ciclo_id, avaliador_id: participacoes.pluck(:participante_id))
    ([self] + children + children.map(&:hierarquia).flatten).uniq
  end

  def percentual_conclusao
    (participacoes.concluida.count / participacoes.count.to_f) * 100
  rescue
    0
  end

  def cache_conclusao!
    update(concluida: participacoes.nao_concluida.empty?)
  end
end

# == Schema Information
#
# Table name: equipes
#
#  id           :bigint           not null, primary key
#  concluida    :boolean          default(FALSE), not null
#  nome         :string           default(""), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  avaliador_id :integer
#  ciclo_id     :bigint           not null
#  padrinho_id  :bigint
#
# Indexes
#
#  index_equipes_on_ciclo_id     (ciclo_id)
#  index_equipes_on_padrinho_id  (padrinho_id)
#
# Foreign Keys
#
#  fk_rails_...  (padrinho_id => usuarios.id)
#
