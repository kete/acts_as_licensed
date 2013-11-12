module ActsAsLicensed
  module RakeHelpers
  	def import_from_yaml(yaml_file)
  	  licenses = YAML.load(File.open("#{gem_root}/seeds/#{yaml_file}"))

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