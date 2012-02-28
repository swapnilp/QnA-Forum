class CreateAnswerratings < ActiveRecord::Migration
  def change
    create_table :answerratings do |t|
      t.references :user, :null => false
      t.references :answer, :null => false
      t.integer :rating, :null => false
      t.timestamps
    end
  end
end
