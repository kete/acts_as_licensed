class Document < ActiveRecord::Base
  acts_as_licensed
	
	def title_for_license
		title
	end

	def author_for_license
		Author.find(author_id).name
	end

	def author_url_for_license
		"/site/account/show/#{author_id}"
	end
		
end

