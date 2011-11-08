class RemoveSlugFromMissions < ActiveRecord::Migration
  def change
    remove_column(:missions, :slug)
  end
end
