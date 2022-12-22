class Participacao < ApplicationRecord
  include ApplicationHelper
  attr_accessor :avatar_url, :feedbacks

  belongs_to :equipe
  belongs_to :participante, class_name: "Usuario"
  belongs_to :agencia
  attachment :avatar
  has_many :feedbacks, -> { order(created_at: :desc) }, dependent: :destroy
  has_one :ciclo, through: :equipe
  has_one :avaliacao

  validates :participante_id, on: :create, exclusion: { in: :participantes_do_ciclo }
  validates_uniqueness_of :participante_id, scope: [:equipe_id]

  scope :por_agencia, -> agencia { joins(:participante).where(agencia: agencia)  }
  scope :concluida, -> { where(concluida: true) }

  before_create :agencia_cache

  delegate :ciclo, to: :equipe

  def self.remove_avatars
    update_all(avatar_id: nil, avatar_filename: nil, avatar_size: nil, avatar_content_type: nil, avatar_aprovado: false)
  end

  def avatar_pendente?
    avatar.present? && !avatar_aprovado?
  end

  def avatar_url
    @avatar_url || ActionController::Base.helpers.asset_path("default_avatar")
  end

  private

  def participantes_do_ciclo
    equipe.ciclo.participacoes.pluck(:participante_id)
  end

  def agencia_cache
    self.agencia = participante.agencia
  end
end

# == Schema Information
#
# Table name: participacoes
#
#  id                  :integer          not null, primary key
#  equipe_id           :integer
#  participante_id     :integer
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_id           :string
#  avatar_filename     :string
#  avatar_size         :integer
#  avatar_content_type :string
#  avatar_aprovado     :boolean          default(FALSE), not null
#  concluida           :boolean          default(FALSE), not null
#  agencia_id          :integer          not null
#  com_copia           :boolean          default(FALSE), not null
#
