class Setting < ActiveRecord::Base
	validates :project_id, presence: true
	belongs_to :project
end
