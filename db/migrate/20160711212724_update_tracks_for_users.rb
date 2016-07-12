class UpdateTracksForUsers < ActiveRecord::Migration
  change_table :tracks do |t|
    t.references :user
  end
end
