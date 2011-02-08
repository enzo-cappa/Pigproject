# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
Pigproject::Application.config.session_store :cookie_store, :key         => '_depot_session',
  :secret      => 'd65174ebcdc77a1745c2c27fc1991e816397a0957d845a96f20b3aaab36016dd9fed8471b301e88e10c2f24849d1b6d2e4e34af5a6646da873f6063b5d2f8c43'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
Pigproject::Application.config.session_store :active_record_store

