class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :long_name
      t.integer :source_id

      t.timestamps
    end
  end
end
