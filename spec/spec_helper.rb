$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'rspec/autorun'
Bundler.require

require 'active_record'

ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

class User < ActiveRecord::Base
#   scope :tender, where { :name =~ 'tender%' }
end

class CreateAllTables < ActiveRecord::Migration
  def up
    create_table(:users) {|t| t.string :name; t.integer :age}
  end
end
ActiveRecord::Migration.verbose = false
CreateAllTables.new.up

# app.config.root = File.dirname(__FILE__)
# Rails.backtrace_cleaner.remove_silencers!
