class ChangeReportTitleToLongText < ActiveRecord::Migration
  def change
  	change_column :reports, :title, :text, :limit => 1048576
  end
end
