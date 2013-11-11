class <%= migration_class_name %> < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.string :name
      t.string :description
      t.string :url
      t.boolean :is_available
      t.string :image_url
      t.boolean :is_creative_commons
      t.text :metadata, null: true
      t.timestamps
    end
  end
end
