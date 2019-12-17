class HomeController < ApplicationController
	def index
    @convoys = Convoy.order(created_at: :desc).last(8)
	end
end
