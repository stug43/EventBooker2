module ApplicationHelper
	def active_class(link_path)
    return (current_page?(link_path) ? 'active' : "")
	end
end
