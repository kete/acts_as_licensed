module ActsAsLicensed
  module Generators
    class CreateMigrationGenerator < Rails::Generators::Base

      include Rails::Generators::Migration
      # # set the root for the source side of our copy operations
      source_root File.expand_path("../templates", __FILE__)

      desc "Creates a new migration file to add the licences table to the DB."

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def create_migration 
        migration_template 'migration.rb', 'db/migrate/add_licenses_table'
      end
    end
  end
end