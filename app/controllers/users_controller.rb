class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @services = @user.daddy_services # Récupère les services de l'utilisateur, pas les rendez-vous
  end

  def profile
    @user = current_user
    @appointments = current_user.appointments.includes(:daddy_service)
  end

  def index

  end
end
