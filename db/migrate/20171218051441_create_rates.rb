class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.float :high
      t.float :low
      t.float :bid
      t.float :ask
      t.float :last
      t.string :pare
      t.integer :source_id

      t.timestamps
    end
  end
end
