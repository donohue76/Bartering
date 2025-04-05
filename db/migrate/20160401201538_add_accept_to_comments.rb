class AddAcceptToComments < ActiveRecord::Migration
  def change
    add_column :comments, :accept, :boolean
  end
end
