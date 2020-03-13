# frozen_string_literal: true

namespace :ridgepole do
  desc 'Apply database schema　and Export database schema'
  task exec: :environment do
    ridgepole('--apply', "-E #{Rails.env}", "--file #{schema_file}")
    ridgepole('--export', "-E #{Rails.env}", "--output #{schema_rb}")
  end

  desc 'Apply database schema'
  task apply: :environment do
    ridgepole('--apply', "-E #{Rails.env}", "--file #{schema_file}")
  end

  desc 'Export database schema'
  task export: :environment do
    ridgepole('--export', "-E #{Rails.env}", "--output #{schema_rb}")
  end

  private

  def schema_file
    Rails.root.join('db/schema/Schemafile') # rubocop:disable Rails/FilePath
  end

  def schema_rb
    Rails.root.join('db/schema.rb') # rubocop:disable Rails/FilePath
  end

  def config_file
    Rails.root.join('config/database.yml') # rubocop:disable Rails/FilePath
  end

  def ridgepole(*options)
    command = ['bundle exec ridgepole', "--config #{config_file}"]
    system [command + options].join(' ')
  end
end
