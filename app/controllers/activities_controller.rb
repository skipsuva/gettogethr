class ActivitiesController < ApplicationController
  def create
    @activity = Activity.new(activity_params.merge({
      gathering_id: params['gathering_id'] }))
    @gathering = Gathering.find(params['gathering_id'])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @gathering, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @gathering }
      else
        format.html {
          flash.now[:error] = 'Activity ' + @activity.errors.messages[:time].join(", ")
          render 'gatherings/show'
        }
        format.json { render json: @gathering.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    params.require(:activity).permit(:description, :activity_category_id)
  end
end
