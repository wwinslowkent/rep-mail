class CreateVote < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :vote, null: false
      t.belongs_to :user
      t.belongs_to :message
  end
  end
end
