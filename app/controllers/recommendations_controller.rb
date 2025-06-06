class RecommendationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_recommendation, only: [:show]

  def index
    @recommendations = Recommendation.includes(:user, :book).order(created_at: :desc)
  end

  def show
    # @recommendation is set by set_recommendation
  end

  def new
    @recommendation = current_user.recommendations.build
    @recommendation.build_book
  end

  def create
    @recommendation = current_user.recommendations.build(recommendation_params)

    if @recommendation.save
      redirect_to @recommendation, notice: 'Recommendation was successfully created.'
    else
      render :new
    end
  end

  private

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end

  def recommendation_params
    params.require(:recommendation).permit(:review, book_attributes: [:id, :title, :author, :image_url])
  end
end

