class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.string :project_id
      t.string :integer

      t.timestamps
    end
  end
end
