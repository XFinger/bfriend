require 'rails/generators/base' 
require 'rails/generators/migration'      
require 'rails/generators/active_record'

class BfriendGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  include Rails::Generators::Migration
  class_option :api, :type => :string, :aliases => "-a", :desc => "Generate contoller methods for API project"
  class_option :ror, :type => :string, :aliases => "-r", :desc => "Generate contoller methods for Rails project"

  # Implement the required interface for Rails::Generators::Migration
  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end

  source_root File.expand_path('../templates', __FILE__)

  def create_migration_file
    migration_template "migration.rb", "db/migrate/create_bfriends.rb"
  end
  
  def add_route  
    route "resources :bfriends" 
  end 
   
  def add_to_user
   inject_into_file 'app/models/user.rb', before: "end"  do  
        "has_many :bfriends  
         has_many :bfriends, :through => :bfriends    
         has_many :inverse_bfriends, :class_name => \"bfriend\", :foreign_key => \"bfriend_id\"       
         has_many :inverse_bfriends, :through => :inverse_bfriends, :source => :user \n"
       
  end

  end
    
  def copy_templates
    if class_option == "api"
      puts "api"
    else puts "not"
    end
    
    template "model.rb", "app/models/bfriend.rb "   
    template "controller.rb", "app/controllers/bfriends_controller.rb"
    
  end 
end