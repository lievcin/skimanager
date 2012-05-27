class Sizes < ActiveRecord::Migration
  def up
    remove_column("skis", "size")
    remove_column("boots", "size")    
    add_column("skis", "size_id", :integer)
    add_column("boots", "size_id", :integer)    
  end

  def down
  end
end
