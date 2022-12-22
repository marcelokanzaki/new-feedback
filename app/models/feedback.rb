class Feedback < ApplicationRecord
  searchkick

  belongs_to :participacao
  belongs_to :autor, class_name: "Usuario"
  has_one :participante, through: :participacao
  has_one :equipe, through: :participacao
  has_one :ciclo, through: :equipe

  after_create  :verifica_possivel_copia
  after_update  :cache_possivel_copia, if: :possivel_copia?
  after_destroy :cache_possivel_copia

  after_update  :cache_conclusao_da_participacao, if: :aprovado?
  after_destroy :cache_conclusao_da_participacao
  after_save :atualizar_conclusao_da_equipe

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
    update_attributes(possivel_copia: possivel_copia)
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
#  id              :integer          not null, primary key
#  participacao_id :integer
#  mensagem        :text             default(""), not null
#  autor_id        :integer          not null
#  aprovado        :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  presencial      :boolean
#  possivel_copia  :boolean          default(FALSE), not null
#
