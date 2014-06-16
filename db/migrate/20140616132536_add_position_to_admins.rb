class AddPositionToAdmins < ActiveRecord::Migration
  def change
   add_column :admins, :position, :integer
  end
end
