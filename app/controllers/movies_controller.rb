class MoviesController < ApplicationController
  def discover
  end

  def index
    @facade = MoviesSearchFacade.new(params[:q])
    if @facade.query_params == ""
      flash[:alert] = "Error: You must provide a query"
      redirect_to "/discover"
    end
  end

  def show 
    @facade = MovieDetailsFacade.new(session[:user_id], params[:id])
  end
end
