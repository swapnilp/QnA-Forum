class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user
      t.references :question
      t.string :answer
      t.float :rating, :default => 3.0
      t.timestamps
    end
  end
end
