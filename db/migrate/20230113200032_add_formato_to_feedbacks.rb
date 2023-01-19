class AddFormatoToFeedbacks < ActiveRecord::Migration[7.0]
  def change
    add_column :feedbacks, :formato, :integer
  end
end
