class BootSize < ActiveRecord::Base
  attr_accessible :size
  has_many :boots  
end
