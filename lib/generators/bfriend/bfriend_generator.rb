require 'rails/generators/base' 
require 'rails/generators/migration'      
require 'rails/generators/active_record'

class BfriendGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  include Rails::Generators::Migration
  class_option :controller_template, :type => :string, :aliases => "-t", :desc => "Template engine for the Controller. Available options are 'api' and 'ror'.", :default => "api"
  class_option :ror, :type => :boolean, :default => false
      
      
  # Implement the required interface for Rails::Generators::Migration
  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end

  source_root File.expand_path('../templates', __FILE__)

  # def create_migration_file
  #   #migration_template "migration.rb", "db/migrate/create_friendships.rb"
  # end
  
  def add_route  
    route "resources :friendships" 
  end 
   
  def add_to_user
   inject_into_file 'app/models/user.rb', before: "end"  do  
        "has_many :friendsips  
         has_many :friends, :through => :friendships    
         has_many :inverse_friendships, :class_name => \"Friendship\", :foreign_key => \"friend_id\"       
         has_many :inverse_friends, :through => :inverse_friendships, :source => :user \n"
       
    end
  end
    
  def copy_templates
    template "model.rb", "app/models/friend.rb"
    if options[:controller_template].to_s == "ror"  or options[:ror]
      template "ror_controller.rb", "app/controllers/friendships_controller.rb"
    else 
      template "api_controller.rb", "app/controllers/friendships_controller.rb"
      #TODO:add serializer
    end
  end 

    def generate_migration
      generate "migration", "create_friendships user_id:integer friend_id:integer"  
    end
   
end