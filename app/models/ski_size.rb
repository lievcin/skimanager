class SkiSize < ActiveRecord::Base
  attr_accessible :size
  has_many :skis
end
