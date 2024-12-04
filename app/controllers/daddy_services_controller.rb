class DaddyServicesController < ApplicationController
  def index
    @daddy_services = DaddyService.all
  end

  def show
    @daddy_service = DaddyService.find(params[:id])
  end

  def new
    @daddy_service = DaddyService.new
  end

  def create
    @daddy_service = DaddyService.new(daddy_service_params)
    @daddy_service.user = current_user
    if @daddy_service.save
      redirect_to daddy_services_path
    else
      render :new
    end
  end

  def edit
    @daddy_service = DaddyService.find(params[:id])
  end

  def update
    @daddy_service = DaddyService.find(params[:id])
    if @daddy_service.update(daddy_service_params)
      redirect_to daddy_services_path
    else
      render :edit
    end
  end

  def destroy
    @daddy_service = DaddyService.find(params[:id])
    @daddy_service.destroy
    redirect_to daddy_services_path
  end

  def search
    @daddy_services = DaddyService.where("title ILIKE ?", "%#{params[:query]}%").limit(5)
    render json: @daddy_services.map { |service|
      {
        id: service.id,
        title: service.title,
        category: service.category.name
      }
    }
  end

# app/controllers/daddy_services_controller.rb
def available_slots
  @daddy_service = DaddyService.find(params[:id])
  date = Date.parse(params[:date])

  # Récupère les créneaux déjà réservés pour cette date
  booked_slots = @daddy_service.appointments
                              .where(date: date.beginning_of_day..date.end_of_day)
                              .pluck(:date)
                              .map { |d| d.strftime("%H:%M") }

  # Crée un tableau de tous les créneaux possibles
  all_slots = (9..17).flat_map do |hour|
    [0, 30].map { |min| sprintf("%02d:%02d", hour, min) }
  end

  # Retire les créneaux déjà réservés
  available_slots = all_slots - booked_slots

  render json: { available_slots: available_slots }
end

  private

  def daddy_service_params
    params.require(:daddy_service).permit(:title, :description, :price, :category_id)
  end
end
