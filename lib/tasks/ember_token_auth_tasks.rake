namespace :ember_token_auth do
  desc "Generator"
  task :install do
    Rake::Task["ember_token_auth:secret"].invoke
    Rake::Task["ember_token_auth:create_user_model"].invoke
    Rake::Task["ember_token_auth:check_schema"].invoke
  end

  desc "Ensures a secret file exists"
  task :secret => :environment do
    puts "Building secret"
    
    target = "#{Rails.root}/config/initializers/secret_token.rb"
    unless File.exist?(target)
      source =  File.join(Gem.loaded_specs["ember_token_auth"].full_gem_path, "config", "initializers", "secret_token.rb.sample")
      cp source, target
    end
  end

  desc "Creates a user model if one doesnt already exist"
  task :create_user_model do
    target = "#{Rails.root}/app/models/user.rb"
    unless File.exist?(target)
      source =  File.join(Gem.loaded_specs["ember_token_auth"].full_gem_path, "app", "models", "user.rb.sample")
      cp source, target
    end    
  end

  desc "Checks that you have a user model"
  task :check_schema => :environment do
    if ActiveRecord::Base.connection.table_exists? 'users'
      unless User.column_names.include?("email")
        puts "*** -> Please add an email attribute to your users table"
      end
      unless User.column_names.include?("password_digest")
        puts "*** -> Please add a password_digest attribute to your users table"
      end
    else
      puts "\n******************************\n"
      puts "Please create a users table with\nan email:string and a password_digest:string field"
      puts "******************************\n"
    end
  end
end