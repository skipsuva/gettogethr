class MomentsController < ApplicationController
  def create
    @moment = Moment.new()
    # @gathering = Gathering.new(gathering_params)
    # @gathering.owner = current_user
    # @gathering.users << current_user

    # respond_to do |format|
    #   if @moment.save
    #     format.html { redirect_to @gathering, notice: 'Gathering was successfully created.' }
    #     format.json { render :show, status: :created, location: @gathering }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @gathering.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def moment_params
    params.require(:moment).permit(:time)
  end
end
