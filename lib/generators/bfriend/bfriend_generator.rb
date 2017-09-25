require 'rails/generators/base' 
require 'rails/generators/migration'      
require 'rails/generators/active_record'

class BfriendGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  include Rails::Generators::Migration

  class_option :controller_template, :type => :string, :desc => "Template engine for the Controller. Available options are 'api' and 'ror'.", :default => "api"
  class_option :ror, :type => :boolean, :default => false
      
      
  # Implement the required interface for Rails::Generators::Migration
  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end

  source_root File.expand_path('../templates', __FILE__)
  
  def add_route  
    route "resources :friendships, only: [:create, :update, :destroy]"
  end 


  def add_to_user
    inject_into_file 'app/models/user.rb', before: "end"  do  
      "include Bfriend\n"   
    end
  end
    
  def copy_templates
    template "model.rb", "app/models/friendship.rb"
    if options[:controller_template].to_s == "ror"  or options[:ror]
      template "ror_controller.rb", "app/controllers/friendships_controller.rb"
    else 
      template "api_controller.rb", "app/controllers/friendships_controller.rb"
    end
  end 

  def generate_migration #after generating the migration, add 'default: false' to status
    generate "migration", "create_friendships user_id:integer friend_id:integer status:boolean "
  end


   
end