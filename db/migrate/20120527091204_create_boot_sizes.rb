class CreateBootSizes < ActiveRecord::Migration
  def change
    create_table :boot_sizes do |t|
      t.string :size

      t.timestamps
    end
  end
end
