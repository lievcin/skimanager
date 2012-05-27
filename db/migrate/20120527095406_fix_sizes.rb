class FixSizes < ActiveRecord::Migration
  def up
    remove_column("skis", "size_id")
    remove_column("boots", "size_id")    
    add_column("skis", "ski_size_id", :integer)
    add_column("boots", "boot_size_id", :integer)    
  end

  def down
  end
end
