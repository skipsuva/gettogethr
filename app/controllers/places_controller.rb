class PlacesController < ApplicationController

  def create
    place = Place.new(place_params.merge({
      gathering_id: params['gathering_id'], user_id: current_user.id }))
    gathering = Gathering.find(params['gathering_id'])

    respond_to do |format|
      if place.save
        format.html { redirect_to gathering, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: gathering }
      else
        format.html {
          flash.now[:error] = place.errors.messages.map { |msg| "<li>#{msg}</li>"}.join('')
          render 'gatherings/show'
        }
        format.json { render json: gathering.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    gathering = Gathering.find(params[:id])
     Place.find(params[:place_id]).destroy
    redirect_to gathering
  end

  private

  def place_params
    params.require(:place).permit(:name)
  end

end
