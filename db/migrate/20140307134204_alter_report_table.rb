class AlterReportTable < ActiveRecord::Migration
  def change
  	remove_column :reports, :integer, :string
  	remove_column :reports, :project_id, :string
    add_column :reports, :project_id, :integer
  end
end
