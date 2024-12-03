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

  private

  def daddy_service_params
    params.require(:daddy_service).permit(:title, :description, :price, :category_id)
  end
end
