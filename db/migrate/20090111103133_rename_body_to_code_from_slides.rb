class RenameBodyToCodeFromSlides < ActiveRecord::Migration
  def self.up
    rename_column :slides, :body, :content_code
    rename_column :slides, :handout, :handout_code
  end

  def self.down
    rename_column :slides, :content_code, :body
    rename_column :slides, :handout_code, :handout
  end
end
