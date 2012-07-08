class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :path, :null => false

      t.timestamps
      
      t.references :user
      t.references :project
      t.references :type
    end
  end
end
