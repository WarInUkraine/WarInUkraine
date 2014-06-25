class AddAuthorLocationToComments < ActiveRecord::Migration
  def change
    add_column :comments, :author_ip, :string
    add_column :comments, :author_location, :string
  end
end
