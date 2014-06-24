class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.references :locatable, polymorphic: true
      t.string :address
      t.float :lat
      t.float :lng
    end
  end

  def down
    drop_table :locations
  end
end
