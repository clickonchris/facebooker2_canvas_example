# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include Facebooker2::Rails::Controller
  
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :set_p3p
  before_filter :ensure_authenticated_to_facebook
  
  #each time a user visits apps.facebook.com/spriteclub, we will refresh their access token
  #1 - check for a user_id from the signed_request
  #2 - check the session for an active user
  #3 - nothing worked.  redirect to the auth page.
  def ensure_authenticated_to_facebook 
    
    if current_facebook_user == nil
      logger.info "no auth token, session, or cookie found."
      top_redirect_to auth_url
    end
    
    #top_redirect_to login_url if current_user == nil
  end
  
  #creates the oauth url for the user to request authorize and authenticate to spriteclub
  # more details on the scope and display options can be found here:
  # http://developers.facebook.com/docs/authentication/
  def auth_url
    url = authenticator.authorize_url(:scope => 'publish_stream,email', :display => 'page')
    logger.info "redirecting to " + url
    return url
  end
  
  def authenticator
    # by redirecting back to HTTP_REFERER, we will go back to the the apps.facebook.com request!
    # if there is no referrer, send this request url as the callback url
    redirect_url = (@_request.env["HTTP_REFERER"] != nil ?
                    @_request.env["HTTP_REFERER"] :  
                    @_request.env["rack.url_scheme"] + "://" + @_request.env["HTTP_HOST"] + @_request.env["REQUEST_PATH"])
    @authenticator ||= Mogli::Authenticator.new(Facebooker2.app_id, 
                                         Facebooker2.secret, 
                                         redirect_url )
  end
  
  # Redirects the top window to the given url if the content is in an iframe, otherwise performs 
  # a normal redirect_to call. 
  def top_redirect_to(url)
      render :layout => false, :inline => '<html><head><script type="text/javascript">window.top.location.href = '+
                                            url.to_json+
                                            ';</script></head></html>'
  end
  
  #we need to set this p3p privacy policy header or facebook connect will never work on IE
  def set_p3p
     response.headers["P3P"]='CP="CAO PSA OUR"'
  end
  
end
