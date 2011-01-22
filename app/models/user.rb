class User < ActiveRecord::Base
  
  def self.for(access_token, expires, facebook_id)
    u = find_or_create_by_facebook_id(facebook_id)
    
      #logger.info "expiration is" + current_facebook_user.client.expiration.to_s
      u.update_attributes(:access_token=>access_token, 
                          :access_token_expires=>Time.at(expires))
    return u
  end
  
  def self.for_facebook_id(facebook_id)
    u = find_or_create_by_facebook_id(facebook_id)
    return u
  end

end
