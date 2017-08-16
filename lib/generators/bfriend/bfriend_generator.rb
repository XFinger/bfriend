require 'rails/generators/base' 
require 'rails/generators/migration'      

class BfriendGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  include Rails::Generators::Migration
  
  # Implement the required interface for Rails::Generators::Migration
  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end

  source_root File.expand_path('../templates', __FILE__)

  def create_migration_file
    migration_template "migration.rb", "db/migrate/migration.rb"
  end
  
  def add_route  
    route "resources :bfriends" 
  end 
   
  def add_to_user
   inject_into_file 'app/models/user.rb', after: "class User < ActiveRecord::Base"  do <<-'RUBY'
     puts   "has_many :bfriends" 
     puts   "has_many :bfriends, :through => :bfriends"  
     puts   "has_many :inverse_bfriends, :class_name => "bfriend", :foreign_key => "bfriend_id" "     
     puts   "has_many :inverse_bfriends, :through => :inverse_bfriends, :source => :user"
     RUBY 
  end

  end
    
  def copy_templates
    template "model.rb", "app/models/bfriend.rb "   
    template "controller.rb", "app/controllers/bfriends_controller.rb"
    
  end 
end