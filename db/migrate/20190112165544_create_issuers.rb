class CreateIssuers < ActiveRecord::Migration[5.1]
  def change
    create_table :issuers do |t|
      t.string :pan
      t.string :url

      t.timestamps
    end
  end
end
