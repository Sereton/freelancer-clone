class CreatePricings < ActiveRecord::Migration[6.0]
  def change
    create_table :pricings do |t|
      t.string :title
      t.text :description
      t.integer :delivery_time
      t.string :price_integer
      t.integer :pricing_type
      t.string :gig
      t.string :references

      t.timestamps
    end
  end
end
