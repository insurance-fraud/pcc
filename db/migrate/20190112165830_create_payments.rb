class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.string :pan
      t.integer :security_code
      t.string :expiry_date
      t.string :card_holder_name
      t.integer :acquirer_order_id
      t.datetime :acquirer_order_timestamp
      t.integer :issuer_order_id
      t.datetime :issuer_order_timestamp
      t.float :amount

      t.timestamps
    end
  end
end
