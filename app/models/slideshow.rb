require 'webthumb'
require 'maruku'
require 'tzinfo'
require 'rwebthumb'

include Simplificator::Webthumb
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
  #after_save :get_thumb
  
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
  
  
  named_scope :published, :order => 'created_at desc', :include => :user, :conditions => {:status => 'published'}
  named_scope :drafted, :order => 'updated_at desc', :include => :user, :conditions => {:status => 'drafted'}

  
  def thumb
    et = Easythumb.new('ba67188b0bb8756435e81118252832e8','4132')
    et.build_url(:url => "#{APP_CONFIG[:site_url]}/slideshows/#{slug}/play", :size => :medium, :cache => 1)
  end
  
  def get_thumb
    puts url = "#{APP_CONFIG[:site_url]}/slideshows/#{slug}/play"
    t = Nailer.new(url)
    if t.ok?
      t.wait_until_ready
      t.retrieve_to_file('out4.jpg', :large)
      puts "Thumbnails saved"
    else
      puts "Error"
    end
  end

  def code_to_html
    self.handout_html = Maruku.new(self.handout_code).to_html
    self.content_html = Maruku.new(self.handout_code).to_html
  end

end
