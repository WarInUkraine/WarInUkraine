class CreateNews < ActiveRecord::Migration
  def up
    create_table :news do |t|
      t.references  :user, index: true
      t.string      :title
      t.string      :description
      t.text        :text
      t.string      :youtube_url, null: true, default: nil
      t.text        :youtube_data
      t.integer     :status, default: 0
      t.timestamp   :happened_at

      t.timestamps
    end
  end

  def down
    drop_table :news
  end
end
