class HomeController < ApplicationController
  
  def index
    current_facebook_user.fetch
    logger.info "hey"
    return
  rescue Exception
      top_redirect_to auth_url

  end


  
end
