class AddAcceptToBarters < ActiveRecord::Migration
  def change
    add_column :barters, :accept, :boolean
  end
end
