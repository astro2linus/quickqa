class ChangeReportsContentColumnToLongText < ActiveRecord::Migration
  def change
  	# change content size limit to 10M
  	change_column :reports, :content, :text, :limit => 10485760
  end
end
