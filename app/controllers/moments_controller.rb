class MomentsController < ApplicationController
  def create
    @moment = Moment.new(moment_params.merge({
      gathering_id: params['gathering_id'] }))
    @gathering = Gathering.find(params['gathering_id'])

    respond_to do |format|
      if @moment.save
        format.html { redirect_to @gathering, notice: 'Moment was successfully created.' }
        format.json { render :show, status: :created, location: @gathering }
      else
        format.html {
          flash.now[:error] = 'Time ' + @moment.errors.messages[:time].join(", ")
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
  def moment_params
    params.require(:moment).permit(:time)
  end
end
