class AddComentarioDoParticipanteToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :comentario_do_participante, :text
  end
end
