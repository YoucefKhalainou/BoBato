class ChangeDateToBeDateInConvoys < ActiveRecord::Migration[5.2]
  def change
  	change_column :convoys, :date_of_departure, :date
  	change_column :convoys, :date_of_arrival, :date
  end
end
