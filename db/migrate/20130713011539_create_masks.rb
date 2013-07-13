class CreateMasks < ActiveRecord::Migration
  def change
    create_table :masks do |t|
      t.string :name

      t.timestamps
    end
  end
end
