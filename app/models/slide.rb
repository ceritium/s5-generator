require 'rubygems'
require 'maruku'

class Slide < ActiveRecord::Base
  include AASM
  
  belongs_to :slideshow
  before_save :code_to_html
  
  named_scope :ordered, :order => 'order_play desc, id asc'
   
  aasm_column :status
  aasm_initial_state :draft
  aasm_state :drafted
  aasm_state :published
  
  aasm_event :publish do
    transitions :to => :published, :from => [:drafted]
  end

  aasm_event :draft do
    transitions :to => :drafted, :from => [:published]
  end
  
  
  def code_to_html
    self.content_html = Maruku.new(self.content_code).to_html
    self.handout_html = Maruku.new(self.handout_code).to_html
  end
  

  
end
