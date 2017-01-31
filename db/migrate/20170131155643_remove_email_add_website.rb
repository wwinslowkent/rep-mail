class RemoveEmailAddWebsite < ActiveRecord::Migration[5.0]
  def change
    remove_column :representatives, :email
    add_column :representatives, :website, :string
  end
end
