class CreateIssue < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
