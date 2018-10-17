desc 'Runs dbcop validations'
task dbcop: :environment do
  byebug
  Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| load(f) }
end
