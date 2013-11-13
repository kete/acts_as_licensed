# ActsAsLicenced

Allows you to add a license to models in your Rails 3/4 apps.

# Install

1. Add this gem to your `Gemfile`:
    ```ruby
    # Gemfile
    gem "acts-as-licenced", git: "kete/acts_as_licensed"
    ```
2. Use the rails generator supplied with this gem to create the migration file that will add the `licence` table to the DB.

    This is a separate step to allow you to customise the migration if you need to.
    ```
    # show all available generators
    $ rails generate

    # run the generator provided by this gem
    $ rails generate acts_as_licensed:create_migration

    # after running the above command, a new migration file will be available 
    # in `db/migrate' dir. You can edit it if you need to.
    ```

3. Migrate your database
    ```
    $ rake db:migrate
    ```

4. Install the licenses you want to assign to content. See a list of them by running
    ```
    $ rake -D acts_as_licensed

    # examples
    $ rake acts_as_licensed:import_all_cc_licenses
    $ rake acts_as_licensed:import_nz_cc_licenses
    $ rake acts_as_licensed:import_au_cc_licenses
    ```

5. Add `acts_as_licensed` to your model(s).
    When an item is released under a certain license, you must specify

    1. **who** is releasing it
    2. **the name** of the thing being released as

    Because this will be different for each object you licence, `acts_as_license` requires three methods to be implemented in any class that include it:

    1. `title_for_license`
    2. `author_for_license`
    3. `author_url_for_license`

    `acts_as_licensed` will use these methods to complete the license.



    For example:
    ```ruby
    class MyThingambob < ActiveRecord::Base
      acts_as_licensed


      # acts_as_licensed requires you to implement these three methods in any model
      # that you include it in

      def title_for_license
        "Footastic Thingambob"
      end

      def author_for_license
        "Mr. Foo"
      end

      def author_url_for_license
        "/users/mr_foo"
      end
    end
    ```

# Usage

## Class Methods

```ruby
# get a list of all available licenses by using
License.find_available
```

## Instance Methods

```ruby
# Check whether the object has a license
object.has_license?

# Update the license, which raises an error if the object already has a license
object.license_id = id_of_new_license

# Retrieve the metadata, html indicating the license type of the object
object.license_metadata
```

## Helper Methods

```ruby
# Check whether licenses are available
licenses_are_available?  

# Get the default license if configured else nil
configured_default_license 

# Iterate over each license
available_licenses do |license|
  puts license.name
end
```

Helper methods for license selection in forms include:

```
radio_button_for_license_selection(object_name, license)
radio_button_with_label_and_image(object_name, method, tag_value, label, image_url = nil, options = {}, options_for_label = {})
radio_button_with_label(object_name, method, tag_value, label, options = {}, options_for_label = {})
```

# TODO

* replace the DEFAULT_CONTENT_LICENSE constant with an appropriate method
* ar_ext.rb mentions the versioning subsystem which should not be tied to this here - fix this when versioning has been upgraded.

# Credits

Some portions (rails generator) based on work by Rob Sanheim in the BrainBuster rails plugin.

*Copyright (c) 2008 Kapito Communications LTD, released under the MIT license.*