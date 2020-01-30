class AddDescriptionToGigs < ActiveRecord::Migration[6.0]
  def change
    add_column :gigs, :description, :text
  end
end
