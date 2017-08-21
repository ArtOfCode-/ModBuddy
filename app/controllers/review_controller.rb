class ReviewController < ApplicationController
  before_action :authenticate_user!
  before_action :set_query
  before_action :check_review

  def review_query
    @data = @query.load
    @results = ReviewResult.where(sede_query: @query, offense_type: @query.offense_type).group(:stack_user_id).count
    @types = ReviewResultType.all
  end

  def submit_result
    @result = ReviewResult.new(sede_query: @query, review_result_type_id: params[:result_type_id], user: current_user,
                               offense_type: @query.offense_type, stack_user_id: params[:stack_user_id])
    if @result.save
      respond_to do |format|
        format.js { @status = true }
      end
    else
      respond_to do |format|
        format.js { @status = false }
      end
    end
  end

  private

  def set_query
    @query = SEDEQuery.find params[:query_id]
  end

  def check_review
    admin_or_role :query_reviewer, scope: @query
  end
end
