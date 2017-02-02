class AddVotesToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :vote, :integer
  end
end
