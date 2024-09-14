class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string :post_code, null: false
      t.integer :area_id, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building_name
      t.string :tel, null: false
      t.references :order_history, null: false, foreign_key: true
      t.timestamps
    end
  end
end
