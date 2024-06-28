Rails.application.config.eager_load_paths += Dir[File.join(Rails.root, "lib", "redis.rb")].each { |l| require l }
