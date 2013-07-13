module ApplicationHelper

	def markActive(path)
	  "active" if current_page?(path)
	end

end
