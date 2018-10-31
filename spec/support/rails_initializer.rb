# frozen_string_literal: true

module RailsInitializer
  def self.run
    require File.expand_path('spec/internal/config/application').to_s
    Rails.application.config.root = File.expand_path('spec/internal').to_s
    Rails.application.initialize!
    Rails.application.eager_load!

    database_yaml = File.read "#{Rails.root}/config/database.yml"
    database_config = YAML.safe_load(
      ERB.new(database_yaml).result, [], [], true
    )
    ActiveRecord::Base.configurations = database_config

    ActiveRecord::Base.establish_connection(database_config['test'].merge('database' => 'postgres'))

    database_name = ActiveRecord::Base.configurations['test']['database']

    ActiveRecord::Base.connection.drop_database(database_name)
    ActiveRecord::Base.connection.create_database(database_name)
    ActiveRecord::Base.clear_active_connections!

    ActiveRecord::Base.establish_connection
    migration_paths = Rails.application.paths['db/migrate'].to_a
    ActiveRecord::MigrationContext.new(migration_paths).migrate
  end
end
