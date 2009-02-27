# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  require 'aasm'
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5cfff15f8de21bd707bb09429f4733f8'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation



  

  protected  
    def add_breadcrumb name, url = '' 
      @breadcrumbs ||= []  
      url = eval(url) if url =~ /_path|_url|@/
      @breadcrumbs << [name, url]  
    end  
  
    def self.add_breadcrumb name, url, options = {}  
      before_filter options do |controller|  
        controller.send(:add_breadcrumb, name, url)  
      end  
    end

    
end
