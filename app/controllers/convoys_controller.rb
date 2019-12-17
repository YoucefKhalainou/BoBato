class ConvoysController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params["search"]
      @filter = params["search"]["ports"].concat(params["search"]["boats"]).flatten.reject(&:blank?)
      @convoys = Convoy.all.global_search("#{@filter}").page(params[:page]).per(6)
    else
      @convoys = Convoy.where("date_of_departure >= ?", Time.current).order(created_at: :desc).page(params[:page]).per(6)
    end

    respond_to do |format|
      format.html {}
      format.js {}
    end 
  end


  def show
    @convoy = Convoy.find(params[:id])
    @id = params[:id]
  end

  def new 
    @convoy = Convoy.new
  end

  def edit
    @convoy = Convoy.find(params[:id])
  end

  def create
    @user = current_user
    @convoy = Convoy.new(convoy_params)
    @convoy.boat_owner = current_user
    
    if @convoy.save
      flash[:success] = "Votre proposition de convoyage est enregistrée avec succés"
      redirect_to @convoy   
    else
      flash[:errors] = @convoy.errors.full_messages
      render 'new'
    end
  end

  def update
    @convoy = Convoy.find(params[:id])
    if @convoy.update(convoy_params)
      flash[:success] = "La mise à jour de votre convoyage est bien enregistrée"
      redirect_to request.referrer
    else
      flash[:errors] = @convoy.errors.full_messages
      redirect_to request.referrer
    end
  end

  def destroy
    @convoy = Convoy.find(params[:id])
    @convoy.destroy
    flash[:success] = "Votre convoyage a été supprimé"
    redirect_to user_my_convoys_path(current_user.id)
  end

  private

  def convoy_params
    params.permit(:title, :boat_type, :required_license, :description, :departure_port, :arrival_port, :date_of_departure, :date_of_arrival, :convoy_price, pictures:[])
  end

end
