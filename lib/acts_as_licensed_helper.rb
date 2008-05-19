
module ActsAsLicensedHelper

  def radio_button_for_license_selection(object_name, license)
    radio_button_with_label(object_name, 'license_id', license.id, license.name) +
    link_to("View license", url_for(license.url), "target" => "_new")
  end
  
  def radio_button_with_label(object_name, method, tag_value, label, options = {}, options_for_label = {})
    id_attr = "#{object_name}_#{method}_#{tag_value}"
    options = { :id => id_attr }.merge(options)
      
    radio_button(object_name, method, tag_value, options) + 
      content_tag('label', label, { :for => id_attr }.merge(options_for_label))
  end
  
  # Iterate over license, i.e.:
  # available_licences do |license|
  #   puts license
  # end
  def available_licenses(&block)
    License.find_available.each do |license|
      block.call(license)
    end
  end
  
  # Checks whether licenses are available for selection
  def licenses_are_available?
    !License.find_available.empty?
  end
  
  # Returns the license id of the default content license or nil
  def configured_default_license
    license = License.find_by_name(DEFAULT_CONTENT_LICENSE)
    license.nil? ? nil : license.id
  end
  
end 
