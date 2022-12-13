class ViewingPartiesController < ApplicationController
  def new
    if session[:user_id]
      @facade = MovieDetailsFacade.new(session[:user_id], params[:movie_id])
    else
      flash[:alert] = "You must register or log in to create a viewing party"
      redirect_to movie_path(params[:movie_id])
    end
  end

  def create
    user = User.find(session[:user_id])
    party = ViewingParty.create(app_params)

    if party.valid?
      UserViewingParty.create(user: user, viewing_party: party, status: 'Hosting')
      params[:invitees].each do |invitee|
        UserViewingParty.create(user_id: invitee, viewing_party: party, status: 'Invited')
      end
      redirect_to "/dashboard"
    else
      flash[:alert] = "Error: #{error_message(party.errors)}"
      redirect_to "/movies/#{params[:movie_id]}/viewing_parties/new"
    end
  end

  private

  def app_params
    params.permit(:movie_title, :duration, :date, :start_time, :movie_id, :run_time)
  end
end
