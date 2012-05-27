class CreateSkiSizes < ActiveRecord::Migration
  def change
    create_table :ski_sizes do |t|
      t.string :size

      t.timestamps
    end
  end
end
