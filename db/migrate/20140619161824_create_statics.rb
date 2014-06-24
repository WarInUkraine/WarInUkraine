class CreateStatics < ActiveRecord::Migration
  def up
    create_table :statics do |t|
      t.string :url
      t.string :title
      t.text :html
    end
  end

  def down
    drop_table :statics
  end
end
