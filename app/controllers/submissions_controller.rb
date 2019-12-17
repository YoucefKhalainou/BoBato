class SubmissionsController < ApplicationController

	before_action :user_restriction,  only: [:index]
	before_action :authenticate_user!, only: [:index, :create]

	def index
		@submissions = current_user.submissions.order(created_at: :desc)
	end

	def create
		@submission = Submission.new(submission_params)
		@submission.skipper = current_user
		if @submission.save
		flash[:success] = "Votre candidature est bien enregistrée"
		redirect_to request.referrer
		else
		flash[:errors] = @submission.errors.full_messages
		redirect_to request.referrer
		end
	end

	def destroy
		@submission = Submission.find_by(submission_params)
		@submission.destroy
		redirect_to request.referrer
	end

  private

	def submission_params
		params.permit(:convoy_id, :skipper_id, :cover_text)
	end

	def user_restriction
		@user = User.find(params[:user_id])
		if @user != current_user
			flash[:errors] = ['Désolé, vous ne pouvez pas accéder à cette page.']
			redirect_to root_path
		end
	end

end
