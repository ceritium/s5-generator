# lib/tasks/populate.rake
namespace :db do
  desc "Fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User, Slideshow, Slide, Comment, Category].each(&:delete_all)
    
    Category.populate 30 do |category|
      category.name     = Populator.words(1).titleize
      category.slug     = SluggableFinder.encode(category.name)
    end
    
    i = 0
    User.populate 40 do |user|
      i += 1
      user.login        = Faker::Internet.user_name + i.to_s
      user.slug         = SluggableFinder.encode(user.login)
      user.email        = Faker::Internet.email
      user.state        = 'active'
      Slideshow.populate 3..20 do |slideshow|
        slideshow.user_id       = user.id
        slideshow.description   = Populator.sentences(1)
        slideshow.category_id   = 1..30
        slideshow.title         = Populator.words(2..6).titleize
        slideshow.foot1         = Populator.words(2..6).titleize
        slideshow.foot2         = Populator.words(2..6).titleize
        slideshow.slug          = SluggableFinder.encode(slideshow.title)
        slideshow.author        = Faker::Name.name
        slideshow.presdate      = Populator.words(2..6).titleize
        slideshow.company       = Faker::Company.name + Faker::Company.suffix
        slideshow.content_code  = Populator.sentences(2..5) 
        slideshow.content_html  = slideshow.content_code
        slideshow.handout_code  = Populator.sentences(2..5)   
        slideshow.handout_html  = slideshow.handout_code
        slideshow.status         = 'published'
        slideshow.views_today   = 0..100
        slideshow.views_this_week  = slideshow.views_today * 7
        slideshow.views_this_month = slideshow.views_this_week * 4
        slideshow.views  = slideshow.views_this_month * 4
        slideshow.created_at    = Time.now-2.year..Time.now
        slideshow.updated_at    = slideshow.created_at..Time.now
        Slide.populate 5..20 do |slide|
          slide.slideshow_id    = slideshow.id
          slide.title           = Populator.words(2..6).titleize
          slide.content_code    = Populator.sentences(2)
          slide.content_html    = slide.content_code
          slide.handout_code    = Populator.sentences(2)
          slide.handout_html    = slide.handout_code
          slide.status         = 'published'
        end
        Comment.populate 15..30 do |comment|
          comment.slideshow_id  = slideshow.id
          comment.user_id       = 1..20
          comment.body          = Populator.paragraphs(1..3) 
        end
      end
    end

   # Comments_counter to slideshows
   Slideshow.reset_column_information
   Slideshow.find(:all).each do |p|
     Slideshow.update_counters p.id, :comments_count => p.comments.length
   end
   # Slideshows_counter to categories
   Category.reset_column_information
   Category.find(:all).each do |p|
     Category.update_counters p.id, :slideshows_count => p.slideshows.length
   end
  end
end