require 'acts_as_licensed/license'

namespace :acts_as_licensed do
  namespace :import do

    desc "Import Australian & New Zealand Creative Commons Licenses from plugin fixtures."
    task all_cc_licenses: :environment do
      import_from_yaml('au_default_creative_commons_licenses.yml')
      import_from_yaml('nz_default_creative_commons_licenses.yml')
    end

    desc "Import New Zealand Creative Commons Licenses from plugin fixtures."
    task nz_cc_licenses: :environment do
      import_from_yaml('nz_default_creative_commons_licenses.yml')
    end

    desc "Import Australian Creative Commons Licenses from plugin fixtures."
    task au_cc_licenses: :environment do
      import_from_yaml('au_default_creative_commons_licenses.yml')
    end

    def import_from_yaml(yaml_file)
      licenses = YAML.load(File.open("#{gem_root}/fixtures/#{yaml_file}"))

      licenses.each do |attrs|
        if license_exists_for?(attrs["url"])
          p "Skipped '#{attrs["name"]}': License already exists."
        else
          begin
            License.create!(attrs)
            p "Inserted license: '#{attrs["name"]}'."
          rescue
            p "Inserting license '#{attrs["name"]} failed: #{$!}."
          end
        end
      end
    end

    def license_exists_for?(url)
      !! License.where(url: url).first
    end

    def gem_root
      File.expand_path('../../..', __FILE__)
    end
  end
end