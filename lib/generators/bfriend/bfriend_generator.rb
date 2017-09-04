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
  
  def add_route  
    route "resources :friendships, only: [:create, :update, :destroy]"
  end 


  def add_to_user
   inject_into_file 'app/models/user.rb', before: "end"  do  
        "
         has_many :friendships
         has_many :bfriended_friendships, :class_name => \"Friendship\", :foreign_key => \"friend_id\"

         # bfriended by me
         has_many :current_friends,       -> { where(friendships: { status: true}) }, through: :friendships, source: :friend
         # bfriended by friend
	       has_many :bfriended_friends,     -> { where(friendships: { status: true}) }, through: :bfriended_friendships, source: :user
         # requested by me
	       has_many :requested_friendships, -> { where(friendships: { status: false}) }, through: :bfriended_friendships, source: :user 
         # requested by friend
         has_many :pending_friends,       -> { where(friendships: { status: false}) }, through: :friendships, source: :friend
         \n
        
         # combine the sets to see all your friends
      	 def friends
	          current_friends | bfriended_friends
	       end

         # combine the sets to see pending and requested friendships
         def pending
		       pending_friends | requested_friendships
	       end
        
         \n 
        "
       
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