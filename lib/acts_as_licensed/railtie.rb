module ActsAsLicensed
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/acts_as_licensed.rake"
    end
  end
end