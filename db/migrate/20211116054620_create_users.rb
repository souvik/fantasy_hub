class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 255, null: false, default: ''
      t.string :last_name, limit: 255, null: false, default: ''
      t.string :email, limit: 255, null: false, default: ''
      t.string :password_digest, limit: 255, null: false

      t.timestamps
    end
  end
end
