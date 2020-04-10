class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :completed
      t.references :list

      t.timestamps null: false
    end
  end
end
