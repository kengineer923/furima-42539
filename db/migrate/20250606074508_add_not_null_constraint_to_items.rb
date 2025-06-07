class AddNotNullConstraintToItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :name, false
    change_column_null :items, :description, false
    change_column_null :items, :price, false
    change_column_null :items, :category_id, false
    change_column_null :items, :condition_id, false
    change_column_null :items, :shipping_payer_id, false
    change_column_null :items, :duration_id, false
    change_column_null :items, :prefecture_id, false
  end
end