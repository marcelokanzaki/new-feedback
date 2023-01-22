class Usuario < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :validatable,
         :rememberable, :recoverable, :trackable

  belongs_to :agencia
  has_many :participacoes, foreign_key: :participante_id
  has_many :feedbacks, -> { order(created_at: :desc) }, through: :participacoes
  has_many :equipes, through: :participacoes

  scope :ativo, -> { where(ativo: true) }

  def to_s
    nome
  end

  def admin?
    @is_admin ||= Permissao.where({
      app: :Feedback,
      namespace: :admin,
      usuario: self
    }).exists?
  end
  alias admin admin?

  def sudo?
    @sudo ||= (ENV["SICOOBTOOLS_SUDOERS"] || "").split(',').map(&:to_i).include?(id)
  rescue
    false
  end
end

# == Schema Information
#
# Table name: usuarios
#
#  id                     :integer          not null, primary key
#  nome                   :string
#  email                  :string           default(""), not null
#  avatar                 :string
#  agencia_id             :integer
#  ativo                  :boolean          default(TRUE)
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  cpf                    :string           default("")
#  data_de_desligamento   :date
#  habilitar_depoimentos  :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#
