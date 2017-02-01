class CreateIssuesMessages < ActiveRecord::Migration[5.0]
    create_table :imessages do |t|
      t.belongs_to :issue
      t.belongs_to :message
  end
end
