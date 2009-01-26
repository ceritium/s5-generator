class CreateSlides < ActiveRecord::Migration
  def self.up
    create_table :slides do |t|
      t.integer :slideshow_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :slides
  end
end
