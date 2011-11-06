# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_expensereport_session',
  :secret      => 'ea9a28b5f8cb208241d23f6c3206c23fec934b7993390ac6a1d8330608a05d4bfed2f1c9310cc1ed42b4f15fe90dbf3003aa5a83804995e91474494c28d95814'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
