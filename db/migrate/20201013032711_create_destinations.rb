class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
    create_table :destinations do |t|
      t.string :post_number, default: "", null: false
      t.integer :region_id, null: false
      t.string :city, default: "", null: false
      t.string :street, default: "", null: false
      t.string :apartment, default: ""
      t.string :telephone, default: "", null: false
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
