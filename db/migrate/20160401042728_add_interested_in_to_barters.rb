class AddInterestedInToBarters < ActiveRecord::Migration
  def change
    add_column :barters, :interested_in, :text
  end
end
