# ActsAsLicenced

Some portions (rails generator) based on work by Rob Sanheim in the BrainBuster rails plugin.

# INSTALL

Install the plugin by running

1. Add this gem to your `Gemfile`

```
# Gemfile
gem "acts-as-licenced", git: "kete/acts_as_licensed"
```

2. Create the migration that adds the `licence` table to your database.

This is a separate step to allow you to customise the migration if you need to.
```
$ ??? ./script/generate acts_as_licensed_migration
```

3. Migrate your database
```
rake db:migrate
```

4. Install the licenses you want to assign to content. See a list of them by running
```
rake -D acts_as_licensed
```

You can also import a set of Creative Commons New Zealand licenses (excluding No Derivate Works variants) using the following command:
```
rake acts_as_licensed:import_nz_cc_licenses"
```

5. Setup controller (???)

Finally, add the following line to the controller which you want to add the licensed plugin to
```
  acts_as_licensed
```

# ADDITIONAL INSTALLATION

ActsAsLicensed relies on three methods within the class you add acts_as_licensed to.

They are title_for_license, author_for_license, and author_url_for_license

The defaults are usually similar to the following (adjust to suit your application):

  def title_for_license
    title
  end
  def author_for_license
    self.author.name
  end
  def author_url_for_license
    "/site/account/show/#{author_id}"
  end

You can also define a default license by setting DEFAULT_CONTENT_LICENSE somewhere in your initializers (the constant contains the id of a license in the license table).


# USAGE

## Class Methods

You can get a list of all available licenses by using

```
  License.find_available
```

## Instance Methods

Check whether the object has a license by using

```
  object.has_license?
```

Update the license, which raises an error if the object already have a license, by using

```
  object.license_id = id_of_new_license
```

Retrieve the metadata, html indicating the license type of the object, by using

```
  object.license_metadata
```

## Helper Methods

```
licenses_are_available?  # Check whether licenses are available through
configured_default_license # Get the default license if configured else nil through
```

Iterate over each license using
```
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


Copyright (c) 2008 ActsAsLicensed Communications LTD, released under the MIT license.
