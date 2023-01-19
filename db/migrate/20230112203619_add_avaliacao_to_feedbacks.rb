class AddAvaliacaoToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :responsabilidade, :integer
    add_column :feedbacks, :comprometimento, :integer
    add_column :feedbacks, :produtividade, :integer
    add_column :feedbacks, :atendimento_humanizado, :integer
  end
end
