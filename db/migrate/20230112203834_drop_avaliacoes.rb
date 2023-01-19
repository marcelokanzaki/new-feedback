class DropAvaliacoes < ActiveRecord::Migration[7.0]
  def change
    drop_table :avaliacoes do |t|
      t.integer :responsabilidade
      t.integer :comprometimento
      t.integer :produtividade
      t.integer :atendimento_humanizado
      t.belongs_to :participacao, null: false, foreign_key: true

      t.timestamps
    end
  end
end
