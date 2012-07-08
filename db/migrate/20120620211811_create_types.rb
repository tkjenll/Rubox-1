class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :description, :null => false
    end
  end
end
