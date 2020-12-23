class AddLatLonToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :lat, :decimal
    add_column :events, :lon, :decimal
  end
end
