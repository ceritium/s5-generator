require 'rubygems'
require 'maruku'
class Slideshow < ActiveRecord::Base
  include AASM

  acts_as_taggable
  
  cattr_reader :per_page
  @@per_page = 12
  
  has_many :slides, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :category
  belongs_to :user
  before_save :code_to_html
  sluggable_finder :title

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


  validates_presence_of :title, :message => 'Rellena los campos obligatorios'
  validates_presence_of :category_id, :message => 'Debes pertenecer a una categoría'
  
  
  named_scope :last_published, :order => 'created_at desc', :include => :user, :conditions => {:status => 'published'}




  def code_to_html
    self.handout_html = Maruku.new(self.handout_code).to_html
    self.content_html = Maruku.new(self.handout_code).to_html
  end

end
