class AddSlugToMissions < ActiveRecord::Migration
  def change
    add_column(:missions, :slug, :string)
    add_index(:missions, :slug)
  end
end
