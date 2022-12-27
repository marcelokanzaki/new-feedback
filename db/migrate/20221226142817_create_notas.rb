class CreateNotas < ActiveRecord::Migration[7.0]
  def change
    create_table :notas do |t|
      t.belongs_to :participante, null: false, foreign_key: { to_table: :usuarios }
      t.belongs_to :avaliador, null: false, foreign_key: { to_table: :usuarios }
      t.text :conteudo

      t.timestamps
    end
  end
end
