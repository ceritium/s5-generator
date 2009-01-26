class AddStateToSlides < ActiveRecord::Migration
  def self.up
    add_column :slides, :status, :string, :default => 'drafted'
  end

  def self.down
    remove_column :slides, :status
  end
end
