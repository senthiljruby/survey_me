class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.integer :user_id
      t.string :question_type
      t.timestamps
    end
  end
end
