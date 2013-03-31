class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :question_id
      t.string :user_answer
      t.integer :user_id
      t.integer :survey_id
      t.timestamps
    end
  end
end
