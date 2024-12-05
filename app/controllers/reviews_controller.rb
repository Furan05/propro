class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @daddy_service = DaddyService.find(params[:daddy_service_id])
    @review = Review.new
  end

  def create
    @daddy_service = DaddyService.find(params[:daddy_service_id])
    @review = @daddy_service.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to daddy_service_path(@daddy_service)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to daddy_service_path(@review.daddy_service)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    daddy_service = @review.daddy_service
    @review.destroy
    redirect_to daddy_service_path(daddy_service)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
