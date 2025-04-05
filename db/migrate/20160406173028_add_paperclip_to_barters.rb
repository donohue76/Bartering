class AddPaperclipToBarters < ActiveRecord::Migration
  def change
    add_attachment :barters, :image
  end
end
