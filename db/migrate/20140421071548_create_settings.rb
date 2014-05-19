class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.string :project_root_path
      t.boolean :enabled
      t.integer :project_id

      t.timestamps
    end
  end
end
