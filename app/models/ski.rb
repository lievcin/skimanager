class Ski < ActiveRecord::Base
  attr_accessible :brand, :condition, :number, :store_id, :ski_size_id
  belongs_to :store
  belongs_to :ski_size
  has_many :packages
  validates :number, :uniqueness => { :scope => :store_id }
  validates :number, :numericality => { :greater_than_or_equal_to => 1 }  
  validates_presence_of :number, :ski_size
  
  
  scope :available, where(:available => '1')
  scope :reserved, where(:available => '0')    
  scope :this_store, lambda { |store|
      where("skis.store_id = ?", store.id)
  }
  
  before_create :allocate
  
  private
  
  def allocate
  self.in_store = true
  self.available = true
  end
  
end
