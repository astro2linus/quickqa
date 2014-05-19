class AddAncestryToSourceFiles < ActiveRecord::Migration
  def change
    add_column :source_files, :ancestry, :string
    add_index :source_files, :ancestry
  end
end
