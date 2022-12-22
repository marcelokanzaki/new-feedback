class Permissao < ApplicationRecord
  belongs_to :usuario
  belongs_to :responsavel, class_name: "Usuario"
end

# == Schema Information
#
# Table name: permissoes
#
#  id             :integer          not null, primary key
#  usuario_id     :integer          not null
#  responsavel_id :integer          not null
#  app            :string           not null
#  namespace      :string           default("admin"), not null
#  created_at     :datetime
#  updated_at     :datetime
#
