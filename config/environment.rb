ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

#ActiveRecord::Base.establish_connection(
#  :adapter => "sqlite3",
#  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#)
#ActiveRecord::Base.establish_connection(
 #:adapter => 'postgresql',
 #:database => ENV['DATABASE_URL'] || 'postgres://localhost/mydb'
 #)

require_all 'app'
