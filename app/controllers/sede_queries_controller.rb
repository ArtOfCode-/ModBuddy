class SEDEQueriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_query, except: [:index, :new, :create]
  before_action :check_modify, except: [:show, :index, :new, :create]
  before_action :check_create, only: [:new, :create]

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
      current_user.add_role(:query_owner, @query)
      current_user.add_role(:query_reviewer, @query)
      flash[:success] = 'Created your query. Use the controls on this page to start using it.'
      redirect_to sede_query_path(@query)
    else
      flash[:danger] = 'Failed to save query; check errors and try again.'
      render :new
    end
  end

  def show
    @data = @query.load
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

  def fetch
    if @query.last_fetch <= 1.day.ago
      if @query.fetch
        flash[:success] = 'Successfully fetched fresh data.'
        @query.update(last_fetch: DateTime.now)
      else
        flash[:danger] = 'Failed to fetch data.'
      end
    else
      flash[:danger] = 'Data fetched within the last day; not re-fetching this early.'
    end
    redirect_to sede_query_path(@query)
  end

  private

  def set_query
    @query = SEDEQuery.find params[:id]
  end

  def check_modify
    admin_or_role :query_owner, scope: @query
  end

  def check_create
    admin_or_role :query_creator
  end

  def query_params
    params.require(:sede_query).permit(:offense_type_id, :url)
  end
end
