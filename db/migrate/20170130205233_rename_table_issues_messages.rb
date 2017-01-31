class RenameTableIssuesMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :imessages do |t|
      t.belongs_to :issue, null: false
      t.belongs_to :message, null: false
    end
  end
end
