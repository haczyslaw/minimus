def require_dir(dir)
  Dir[APP_ROOT + dir].each do |file|
    require file
  end
end

["/lib/**/*.rb",
  "/config/initializers/**/*.rb",
  "/app/**/*.rb"].
  each{|d| require_dir(d)}

require File.expand_path('../routes.rb',__FILE__)
