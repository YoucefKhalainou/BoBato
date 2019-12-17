class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
	
	def create
		@comment = Comment.new(params.permit(:review))
		@comment.user = current_user
		@comment.recipient = User.find(params[:recipient_id])
    if @comment.save
      flash[:success] = "Votre commentaire a été publié avec succès."
      redirect_to request.referrer  
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to request.referrer  
    end
	end

	private

	def comment_params
		params.permit(:review)
	end
	
end
