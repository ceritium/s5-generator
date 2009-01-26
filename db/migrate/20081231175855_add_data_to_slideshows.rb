class AddDataToSlideshows < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :author, :string
    add_column :slideshows, :presdate, :string
    add_column :slideshows, :company, :string
    add_column :slideshows, :format, :string
    add_column :slides, :handout, :text
  end

  def self.down
    remove_column :slideshows, :author
    remove_column :slideshows, :presdate
    remove_column :slideshows, :company
    remove_column :slideshows, :format
    remove_column :slides, :handout
  end
end
