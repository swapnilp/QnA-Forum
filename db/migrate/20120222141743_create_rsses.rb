class CreateRsses < ActiveRecord::Migration
  def change
    create_table :rsses do |t|
      t.references :user, :null => false
      t.string :comment, :null => false
      t.string :location, :null => false
      t.timestamps
    end
  end
end
