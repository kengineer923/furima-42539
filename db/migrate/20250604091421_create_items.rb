class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :user, null: false, foreign_key: true
      t.integer :category_id
      t.integer :condition_id
      t.integer :shipping_payer_id
      t.integer :duration_id
      t.integer :prefecture_id

      t.timestamps
    end
  end
end