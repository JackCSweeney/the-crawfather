class CreateUserSleeperLeague < ActiveRecord::Migration[7.1]
  def change
    create_table :user_sleeper_leagues do |t|
      t.string :league_name
      t.integer :sleeper_league_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
