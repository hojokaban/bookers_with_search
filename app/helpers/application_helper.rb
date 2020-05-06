module ApplicationHelper

	def search_by(key, way)
		case way.to_i
		when 1
			"#{key}"
		when 2
			"#{key}%"
		when 3
			"%#{key}"
		when 4
			"%#{key}%"
		else
			flash[:notice] = "Select the way you search the object"
			return
		end
	end
end
