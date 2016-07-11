class AddUpvote < ActiveRecord::Migration
  def change
    create_table :upvote |t|
    t.references :user
    t.references :track
    t.date :created_at
    t.date :updated_at
  end
end
