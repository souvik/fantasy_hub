class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, limit: 200, null: false, default: ''
      t.string :short_name, limit: 200, null: false, default: ''
      t.string :slug, limit: 255, null: false, default: '', index: true
      t.string :abbreviation, limit: 100, null: false, default: ''
      t.string :jersey_image_url, limit: 255, null: false, default: ''
      t.string :logo_image_url, limit: 255, null: false, default: ''
      t.string :badge_image_url, limit: 255, null: false, default: ''
      t.timestamps
    end
  end
end
