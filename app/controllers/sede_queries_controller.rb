class SEDEQueriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_query, except: [:index]
  before_action :check_permissions, except: [:show, :index]

  def index
    @queries = SEDEQuery.all
  end

  def new
    @query = SEDEQuery.new
  end

  def create
    @query = SEDEQuery.new query_params
    @query.last_fetch = Date.new(1970, 1, 1)
    if @query.save
      flash[:success] = 'Created your query. Use the controls on this page to start using it.'
      redirect_to sede_query_path(@query)
    else
      flash[:danger] = 'Failed to save query; check errors and try again.'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @query.update query_params
      flash[:success] = 'Updated your query.'
      redirect_to sede_query_path(@query)
    else
      flash[:danger] = 'Failed to save query; check errors and try again.'
      render :edit
    end
  end

  def destroy
    if @query.destroy
      flash[:success] = 'Removed your query.'
      redirect_to sede_queries_path
    else
      flash[:danger] = 'Failed to remove query.'
      render :show
    end
  end

  private

  def set_query
    @query = SEDEQuery.find params[:id]
  end

  def check_permissions
    admin_or_role :query_owner, scope: @query
  end

  def query_params
    params.require(:sede_query).permit(:offense_type_id, :url)
  end
end
