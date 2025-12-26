class AddStorageToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :storage, :integer
  end
end
