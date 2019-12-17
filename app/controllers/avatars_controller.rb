class AvatarsController < ApplicationController
  def create
  	@profile = Profile.find(params[:profile_id])
    @profile.avatar.attach(params[:avatar])
    redirect_to(profile_path(@profile))
  end

  private

  def profile_params
   params.permit(:avatar)
  end

 
end
