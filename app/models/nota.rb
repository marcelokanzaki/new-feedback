class Nota < ApplicationRecord
  belongs_to :participante, class_name: "Usuario"
  belongs_to :avaliador, class_name: "Usuario"
  has_rich_text :texto
end

# == Schema Information
#
# Table name: notas
#
#  id              :bigint           not null, primary key
#  conteudo        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  avaliador_id    :bigint           not null
#  participante_id :bigint           not null
#
# Indexes
#
#  index_notas_on_avaliador_id     (avaliador_id)
#  index_notas_on_participante_id  (participante_id)
#
# Foreign Keys
#
#  fk_rails_...  (avaliador_id => usuarios.id)
#  fk_rails_...  (participante_id => usuarios.id)
#
