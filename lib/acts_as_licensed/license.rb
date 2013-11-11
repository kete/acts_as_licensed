class License < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :url
  validates_inclusion_of :is_available, in: [true, false], message: "must be true or false"
  validates_inclusion_of :is_creative_commons, in: [true, false], message: "must be true or false"

  def self.find_available
    # RABID: TODO: should this be License.where(is_available: true) in rails 3/4?
    License.find(:all, :conditions => ['is_available', true])
  end

  def title
    name
  end
end