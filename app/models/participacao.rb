class Participacao < ApplicationRecord
  include ApplicationHelper

  belongs_to :equipe
  belongs_to :participante, class_name: "Usuario"
  belongs_to :agencia
  attachment :avatar
  has_many :feedbacks, -> { order(created_at: :desc) }, dependent: :destroy
  has_one :ciclo, through: :equipe

  validates :participante_id, on: :create, exclusion: { in: :participantes_do_ciclo }
  validates_uniqueness_of :participante_id, scope: [:equipe_id]

  scope :por_agencia, -> agencia { joins(:participante).where(agencia: agencia)  }
  scope :concluida, -> { where(concluida: true) }

  before_validation :set_agencia

  delegate :ciclo, to: :equipe

  def self.remove_avatars
    update_all(avatar_id: nil, avatar_filename: nil, avatar_size: nil, avatar_content_type: nil, avatar_aprovado: false)
  end

  def avatar_pendente?
    avatar.present? && !avatar_aprovado?
  end

  private

  def participantes_do_ciclo
    equipe.ciclo.participacoes.pluck(:participante_id)
  end

  def set_agencia
    self.agencia = participante.agencia
  end
end

# == Schema Information
#
# Table name: participacoes
#
#  id                  :bigint           not null, primary key
#  avatar_aprovado     :boolean          default(FALSE), not null
#  avatar_content_type :string
#  avatar_filename     :string
#  avatar_size         :integer
#  com_copia           :boolean          default(FALSE), not null
#  concluida           :boolean          default(FALSE), not null
#  created_at          :datetime
#  updated_at          :datetime
#  agencia_id          :integer          not null
#  avatar_id           :string
#  equipe_id           :bigint
#  participante_id     :integer
#
# Indexes
#
#  index_participacoes_on_equipe_id  (equipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (equipe_id => equipes.id)
#
