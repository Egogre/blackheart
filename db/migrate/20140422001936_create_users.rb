class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.boolean :premium_member?
      t.boolean :isadmin? (researdh oAuth)
      t.timestamps
    end
  end
end
