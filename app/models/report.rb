class Report < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	validates :project_id, presence: true
	belongs_to :project

	def dump_report
    tmp_path = Rails.root.join("tmp/tmp_report/test.json")
    system("rm -f #{tmp_path}")
    File.open(tmp_path, 'w+' ) do |out|
      out << self.content
    end
  end
end
