class RemoveCzips < ActiveRecord::Migration[5.0]
  def change
    remove_column :representatives, :czip
  end
end
