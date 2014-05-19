class CreateSourceFiles < ActiveRecord::Migration
  def change
    create_table :source_files do |t|
      t.string :file_name
      t.string :file_path
      t.text :content
      t.integer :project_id

      t.timestamps
    end
  end
end
