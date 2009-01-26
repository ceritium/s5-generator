module SlideshowsHelper
  
  def embed(slideshow, width='580', height='350')
    "<iframe src=#{play_slideshow_path(slideshow)} width='#{width}' height=#{height}}>You browser don´t support iframes</iframe>"
  end
  
  
  def screenshot(title, size='60')
    image_tag 'http://www.gravatar.com/avatar/' + Digest::MD5.new.hexdigest(title) + '?d=identicon&s=' + size + '&r=p'
    
    #http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?d=identicon
    #http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?d=monsterid
    #http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802?d=wavatar
  end
end
