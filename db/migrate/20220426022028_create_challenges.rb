class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :challenge_description
      t.string :output_description
      t.string :output
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
