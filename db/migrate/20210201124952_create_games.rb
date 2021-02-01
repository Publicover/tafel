class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.date :schedule_date
      t.integer :team_ids, default: [], array: true

      t.timestamps
    end
  end
end
