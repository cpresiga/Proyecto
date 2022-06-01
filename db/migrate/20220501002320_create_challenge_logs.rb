class CreateChallengeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :challenge_logs do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.string  :sourcode
      t.string  :status
      t.string  :errorCode
      t.string  :error
      t.string  :output
      t.string  :language
      t.timestamps
    end
  end
end
