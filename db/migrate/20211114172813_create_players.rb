class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name, limit: 255, null: false, default: ''
      t.string :last_name, limit: 255, null: false, default: ''
      t.references :team, index: true
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0
      t.boolean :is_constructor, null: false, default: false
      t.timestamps
    end
  end
end
