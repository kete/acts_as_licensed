class License < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :url
  validates_inclusion_of :is_available, in: [true, false], message: "must be true or false"
  validates_inclusion_of :is_creative_commons, in: [true, false], message: "must be true or false"

  def self.find_available
    License.where(is_available: true)
  end

  def title
    name
  end
end