class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :track
      t.text :review
      t.integer :stars
      t.date :created_at
      t.date :updated_at
    end
  end
end
