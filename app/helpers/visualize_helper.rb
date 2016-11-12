module VisualizeHelper
	def google_api
		content_for :head do
			javascript_include_tag "//www.google.com/jsapi", "chartkick"
		end
	end
end
