require 'rails/generators/base' 
require 'rails/generators/migration'      

class BfriendGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  include Rails::Generators::Migration
  
 
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
  # Every method that is declared below will be automatically executed when the generator is run

 def create_migration_file
   f = File.open File.join(File.dirname(__FILE__), 'templates', 'schema.rb')
   schema = f.read; f.close
   
   schema.gsub!(/ActiveRecord::Schema.*\n/, '')
   schema.gsub!(/^end\n*$/, '')

   f = File.open File.join(File.dirname(__FILE__), 'templates', 'migration.rb')
   migration = f.read; f.close
   migration.gsub!(/SCHEMA_AUTO_INSERTED_HERE/, schema)
   
   tmp = File.open "tmp/~migration_ready.rb", "w"
   tmp.write migration
   tmp.close

   migration_template  'tmp/~migration_ready.rb',
     "db/migrate/create_bfriends.rb "
   remove_file 'tmp/~migration_ready.rb'
 end
 
 
  def add_route  
    route "resources bfriends.to_sym.inspect" 
    #resources :befriends
    # route "match 'download' => '#{plural_name}#download', :as => :download"
    # route "match 'download_html' => '#{plural_name}#download_html', :as => :download_html"
  end 
   
  def add_to_user
   inject_into_file 'app/models/user.rb', after: "class User < ActiveRecord::Base"  do 
     <<-RUBY
        has_many :bfriends
        has_many :bfriends, :through => :bfriends
        has_many :inverse_bfriends, :class_name => "bfriend", :foreign_key => "bfriend_id"
        has_many :inverse_bfriends, :through => :inverse_bfriends, :source => :user

     RUBY
 end

end
    
  def copy_templates
    template "model.rb", "app/models/bfriend.rb "   
    template "controller.rb", "app/controllers/bfriends_controller.rb"
    
  end 
  
 
  
  # def class_name
  #   name.camelize
  # end 
  # def plural_class_name
  #   plural_name.camelize
  # end
end