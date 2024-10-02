class AddUserSleeperAccount < ActiveRecord::Migration[7.1]
  def change
    create_table :user_sleeper_account do |t|
      t.string :sleeper_username
      t.integer :sleeper_user_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
