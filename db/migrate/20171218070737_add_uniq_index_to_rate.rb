class AddUniqIndexToRate < ActiveRecord::Migration[5.1]
  def change
    add_index :rates, :pare, unique: true
  end
end
