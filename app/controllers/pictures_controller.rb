class PicturesController < ApplicationController
	
	def create
  	@convoy = Convoy.find(params[:convoy_id])
  	@convoy.pictures.attach(params[:pictures])
    redirect_to(edit_convoy_path(@convoy))
  end
end
