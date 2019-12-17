class MyConvoysController < ApplicationController
	before_action :user_restriction
	before_action :authenticate_user!, only: [:index, :show]

	def index
		@my_convoys = User.find(params[:user_id]).convoys.order(created_at: :desc)
		@user = User.find(params[:user_id])
	end

	def show
		@my_convoy = Convoy.find(params[:id])
		@id = params[:id]
		@submissions = Submission.where(convoy: @my_convoy)
	end

	private

	def user_restriction
		@user = User.find(params[:user_id])
		if @user != current_user
			flash[:errors] = ['Désolé, vous ne pouvez pas accéder à cette page.']
			redirect_to root_path
		end
	end

end
