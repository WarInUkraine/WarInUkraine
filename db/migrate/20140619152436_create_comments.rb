class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.string :email
      t.string :author
      t.text :text
      t.integer :status

      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
