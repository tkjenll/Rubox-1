class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|

      t.timestamps
      
      t.references :user
      t.references :project
      t.references :type
    end
  end
end
