class CreateCoordinates < ActiveRecord::Migration[6.0]
  def change
    create_table :coordinates do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
