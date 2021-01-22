class CreateFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :followers, id: false do |t|
      t.integer "follower_id"
      t.integer "followed_id"
      t.datetime :created_at, null: false
    end
  end
end
