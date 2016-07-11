class UpdateTracksForUsers < ActiveRecord::Migration
  def change
    add_column :tracks, :user_id :references
  end
end
