class AddLikersCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :likers_count, :integer, :default => 0
  end
end
