class Nota < ApplicationRecord
  belongs_to :participante, class_name: "Usuario"
  belongs_to :avaliador, class_name: "Usuario"
  has_rich_text :texto
end
