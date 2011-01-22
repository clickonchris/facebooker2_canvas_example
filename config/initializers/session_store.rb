# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_facebooker2_canvas_example_session',
  :secret      => 'aa95e9613ed56c6b8ae549549cf338feebe803549256c54d41df64aacb3644f0e09ad28e734cdb87d74b701208449368959aeafe74d05df99e8e29b9ef80eb51'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
