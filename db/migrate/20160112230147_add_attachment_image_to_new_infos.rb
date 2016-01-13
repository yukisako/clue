class AddAttachmentImageToNewInfos < ActiveRecord::Migration
  def self.up
    change_table :new_infos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :new_infos, :image
  end
end
