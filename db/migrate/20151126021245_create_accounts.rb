class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.text :api_token, null: false, index: true
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
