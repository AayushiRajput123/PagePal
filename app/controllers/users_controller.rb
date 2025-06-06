class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @recommended_books = @user.recommendations.includes(:book)
    @total_votes_received = @user.recommendations.joins(:votes).count
  end
end

