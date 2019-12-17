class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
  	@profile = Profile.find(params[:id])
    @comments = Comment.where(profile_id: @profile.id)
  end

  def edit
  	@profile = Profile.find(params[:id])
  end

  def update
  	@profile = Profile.find(params[:id])
    if @profile.update(first_name: params[:first_name],last_name: params[:last_name],birthdate: params[:birthdate], description: params[:description],city: params[:city])
      flash[:success] = 'Votre profil a bien été modifié'
      redirect_to request.referrer
    else
      flash[:errors] = ["Erreur, votre profil n'a pas pu être modifié"]
      redirect_to request.referrer
    end

  end
end
