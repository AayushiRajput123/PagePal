# app/controllers/votes_controller.rb
class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @recommendation = Recommendation.find(params[:recommendation_id])
    @vote = @recommendation.votes.new(user: current_user)

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @recommendation, notice: 'Upvoted!' }
        format.turbo_stream # For live updates
      else
        format.html { redirect_to @recommendation, alert: @vote.errors.full_messages.to_sentence }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("recommendation_#{@recommendation.id}_vote_status", partial: "recommendations/vote_status", locals: { recommendation: @recommendation }), status: :unprocessable_entity }
      end
    end
  end
end