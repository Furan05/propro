class CategoriesController < ApplicationController
  before_action :set_category, only: [:update]

  # Mettre à jour une catégorie pour associer un service
  def update
    @daddy_service = DaddyService.find(params[:daddy_service_id])
    @daddy_service.category = @category

    if @daddy_service.save
      redirect_to @daddy_service, notice: 'Service was successfully associated with the category.'
    else
      render :edit
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
