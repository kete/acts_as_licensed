require 'acts_as_licensed/license'
require 'acts_as_licensed/rake_helpers'

namespace :acts_as_licensed do
  namespace :import do
    include ActsAsLicensed::RakeHelpers

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
  end
end