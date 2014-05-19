class AddNodeTypeToSourceFiles < ActiveRecord::Migration
  def change
    add_column :source_files, :node_type, :string
  end
end
