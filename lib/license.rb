class License < ActiveRecord::Base
  
  # Add association users (special case, others handled through acts_as_licensed 
  # class method)
  has_many :users, :dependent => :nullify
  
  class << self
    
    def find_available
      License.find(:all, :conditions => ['is_available', true])
    end
    
  end
  
  def title
    name
  end
  
end
