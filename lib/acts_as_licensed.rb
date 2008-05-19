# ActsAsLicensed

require 'active_record'

module Katipo
  module Acts #:nodoc:
    module Licensed #:nodoc:

      def self.included(mod)
      	mod.class_eval do 
         	  extend(ClassMethods)
      	end
      end

      # declare the class level helper methods which
      # will load the relevant instance methods
      # defined below when invoked
      module ClassMethods
        def acts_as_licensed
          include Katipo::Acts::Licensed::InstanceMethods
          
          # Add association
          belongs_to :license
          
          # Add association to License class
          License.has_many self.table_name.to_sym, :dependent => :destroy
          
          # Tell ActsAsVersioned to ignore the license_id column (not versioned)
          non_versioned_fields << "license_id" if respond_to?(:non_versioned_fields)
        end
      end


      # Adds instance methods.
      module InstanceMethods
        
        # Returns license meta from License#metadata with replacement strings
        # replaced with values as per replacement equivalents hash.
        def license_metadata
          return nil if license.nil?
          
          # Hash for license metadata replacements
          # Replacement :key => 'value'
          replacements = {
            :license_url => license.url,
            :license_title => license.name,
            :license_image_url => license.image_url,
            :title => :title_for_license,
            :attribute_work_to_url => :author_url_for_license,
            :attribute_work_to_name => :author_for_license
          }
          
          # Replace keys with actual values as appropriate.
          signature = /(\${2}[a-zA-Z0-9\-\_]+\${2})/
          license.metadata.gsub(signature) do |match|
            value = replacements[match.gsub(/\$/, '').to_sym]
            
            # If replacement value is a symbol, send the symbol to self
            # so as to raise errors when compulsory methods are not implemented.
            value.kind_of?(Symbol) ? send(value) : value
          end
        end
        
        # Check if the item has a license or not.
        def has_license?
          !license.nil?
        end
        
        def license_id=(*args)
          if !has_license?
            super(*args)
          else
            raise "You may not set license_id more than once"
            logger.info "Error: license_id was attempted to be set when already set."
          end
        end
        
        # Stubs for possibly methods that licenseable objects need to implement to work with acts_as_licensed,
        # depending on license metadata choosen by administrators.
        # if !klass.instance_methods.member?("author_for_license")
        #   def author_for_license
        #     raise "If using $$attribute_work_to_name$$ in license metadata, author_for_license must be implemented by the licenseable object."
        #   end
        # end
        # 
        # if !instance_methods.member?("author_url_for_license")
        #   def author_url_for_license
        #     raise "If using $$attribute_work_to_url$$ in license metadata, author_url_for_license must be implemented by the licenseable object."
        #   end
        # end
        # 
        # if !instance_methods.member?("title_for_license")
        #   def title_for_license
        #     raise "If using $$license_title$$ in license metadata, title_for_license must be implemented by the licenseable object."
        #   end
        # end
        
      end

    end
  end
end

ActiveRecord::Base.send(:include, Katipo::Acts::Licensed) 
