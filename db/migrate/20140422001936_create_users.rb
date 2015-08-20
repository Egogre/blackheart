class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.boolean :premium_member?
      t.boolean :isadmin?
      t.timestamps
    end
  end
end
