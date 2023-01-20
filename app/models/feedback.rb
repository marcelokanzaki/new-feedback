class Feedback < ApplicationRecord
  searchkick

  CRITERIOS_DE_AVALIACAO = [:responsabilidade, :comprometimento, :produtividade, :atendimento_humanizado].freeze

  belongs_to :participacao
  belongs_to :autor, class_name: "Usuario"
  has_one :avaliacao, through: :participacao
  has_one :participante, through: :participacao
  has_one :equipe, through: :participacao
  has_one :ciclo, through: :equipe

  enum formato: [:conversa_presencial, :video_chamada, :somente_registro_online]

  scope :por_participante, -> participante { joins(:participacao).where(participacoes: { participante: participante }) }

  after_create  :verifica_possivel_copia
  after_update  :cache_possivel_copia, if: :possivel_copia?
  after_destroy :cache_possivel_copia

  after_update  :cache_conclusao_da_participacao, if: :aprovado?
  after_destroy :cache_conclusao_da_participacao
  after_save :atualizar_conclusao_da_equipe

  def avaliacao?
    CRITERIOS_DE_AVALIACAO.map { |criterio| send(criterio).present? }.all?
  end

  private

  def cache_conclusao_da_participacao
    concluida = Feedback.where(participacao: participacao, aprovado: true).exists?
    participacao.update_attributes(concluida: concluida)
  end

  def verifica_possivel_copia
    reindex
    possivel_copia = similar(
      fields: [:mensagem],
      body_options: { min_score: 1.2 },
      where: { autor_id: { all: [autor.id] }}
    ).any?
    update_attribute(:possivel_copia, possivel_copia)
  end

  def cache_possivel_copia
    possivel_copia = Feedback.where(participacao: participacao, possivel_copia: true).exists?
    participacao.update_attributes(com_copia: possivel_copia)
  end

  def atualizar_conclusao_da_equipe
    equipe.update_attribute(:concluida, !equipe.participacoes.where(concluida: false).exists?)
  end
end

# == Schema Information
#
# Table name: feedbacks
#
#  id                         :bigint           not null, primary key
#  aprovado                   :boolean          default(FALSE), not null
#  atendimento_humanizado     :integer
#  comentario_do_participante :text
#  comprometimento            :integer
#  formato                    :integer
#  mensagem                   :text             default(""), not null
#  possivel_copia             :boolean          default(FALSE), not null
#  presencial                 :boolean
#  produtividade              :integer
#  responsabilidade           :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  autor_id                   :integer          not null
#  participacao_id            :bigint
#
# Indexes
#
#  index_feedbacks_on_participacao_id  (participacao_id)
#
# Foreign Keys
#
#  fk_rails_...  (participacao_id => participacoes.id)
#
