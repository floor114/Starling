class AddLikeesCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :likees_count, :integer, :default => 0
  end
end
