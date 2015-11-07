class AddLikeesCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :likees_count, :integer, :default => 0
  end
end
