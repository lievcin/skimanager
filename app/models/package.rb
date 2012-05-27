class Package < ActiveRecord::Base
  attr_accessible :boot_id, :customer_id, :end_date, :ski_id, :start_date
  validates_presence_of :customer_id, :start_date, :end_date, :ski_id, :boot_id
  belongs_to :customer 
  belongs_to :boot
  belongs_to :ski
  has_many :rentals
  after_create :reserve_kit
  before_destroy :release_kit
  before_update :release_kit
  after_update :reserve_kit
      
  private
      
  def reserve_kit
    @boot = self.boot
    @boot.available = false
    @boot.save
    @ski = self.ski
    @ski.available = false
    @ski.save    
  end
  
  def release_kit
    @boot = self.boot
    @boot.available = true
    @boot.in_store = true    
    @boot.save
    @ski = self.ski
    @ski.available = true
    @ski.in_store = true        
    @ski.save    
  end

  def check_expiration
    puts 'clwlkwclwkchlckwhlkhclwkdhcwdlkchwldkchkclwhckldhclkwdclwdkckh'
  end
    
end
